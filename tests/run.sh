#!/bin/bash -eu

source_root=$(python -c "from os import path; print(path.abspath(path.join(path.dirname('$0'), '..')))")

cd "${source_root}"

find -name '*.sh' -exec shellcheck {} +
find -name '*.bats' -exec tests/batscheck.sh {} +

rm -rf tests/integration/{.coverage,htmlcoverage}

tests/integration/integration.bats
tests/integration/report.sh
