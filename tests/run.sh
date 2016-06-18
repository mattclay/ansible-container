#!/bin/bash -eu

source_root=$(python -c "from os import path; print(path.abspath(path.join(path.dirname('$0'), '..')))")

cd "${source_root}"

find -name '*.sh' -exec shellcheck {} +
find -name '*.bats' -exec tests/batscheck.sh {} +

rm -rf tests/integration/{.coverage,htmlcoverage}

docker_version=$(docker version \
    | grep '^Server:$' -A 100 \
    | grep '^ API version:' \
    | sed 's/^ API version:  *//')

export DOCKER_API_VERSION="${docker_version}"

if [ "${TRAVIS:-}" = "true" ]; then
    env
fi

tests/integration/integration.bats
tests/integration/report.sh
