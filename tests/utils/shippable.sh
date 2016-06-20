#!/bin/bash -eu

apt-add-repository 'deb http://archive.ubuntu.com/ubuntu trusty-backports universe'
apt-get update -qq
apt-get install -y shellcheck

pip install -r requirements.txt -r tests/requirements.txt

python setup.py develop
docker version
docker-compose version

function finish
{
    # make sure shippable has testresults and codecoverage even on build failure

    mkdir -p shippable/testresults
    mkdir -p shippable/codecoverage

    for type in unit integration; do
        cp -av tests/reports/${type}/junit.xml    shippable/testresults/${type}.xml  || true
        cp -av tests/reports/${type}/coverage.xml shippable/codecoverage/${type}.xml || true
    done
}

trap finish EXIT INT TERM
tests/utils/run_tests.sh

bash <(curl -s https://codecov.io/bash) -F unit        -f tests/reports/unit/coverage.xml
bash <(curl -s https://codecov.io/bash) -F integration -f tests/reports/integration/coverage.xml
