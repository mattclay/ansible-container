#!/bin/bash -eu

source_root=$(python -c "from os import path; print(path.abspath(path.join(path.dirname('$0'), '../..')))")
test_dir="${source_root}/tests"

cd "${source_root}"

# static code analysis
find -name '*.sh' -exec shellcheck {} +
find -name '*.bats' -exec "${test_dir}/utils/batscheck.sh" {} +

# enable code coverage for tests
rm -rf "${test_dir}/reports"
mkdir -p "${test_dir}/reports/data"
export COVERAGE_FILE="${test_dir}/reports/data/coverage"
PATH="${test_dir}/utils/coverage:$PATH"

# run tests
bats "${test_dir}/integration"

# generate code coverage reports
coverage combine
coverage html --dir "${test_dir}/reports/html"
coverage xml
coverage report
