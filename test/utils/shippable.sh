#!/bin/bash -eu

apt-add-repository 'deb http://archive.ubuntu.com/ubuntu trusty-backports universe'
apt-get update -qq
apt-get install -y shellcheck

pip install -r requirements.txt -r test/requirements.txt

python setup.py develop
docker version
docker-compose version

function finish
{
    # make sure shippable has testresults and codecoverage even on build failure

    mkdir -p shippable/testresults
    mkdir -p shippable/codecoverage

    for type in unit integration; do
        cp -av test/reports/${type}/junit.xml    shippable/testresults/${type}.xml  || true
        cp -av test/reports/${type}/coverage.xml shippable/codecoverage/${type}.xml || true
    done
}

trap finish EXIT INT TERM
test/utils/run_tests.sh

bash <(curl -s https://codecov.io/bash) -F unit        -f test/reports/unit/coverage.xml
bash <(curl -s https://codecov.io/bash) -F integration -f test/reports/integration/coverage.xml
