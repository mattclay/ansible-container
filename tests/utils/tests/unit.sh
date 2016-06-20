#!/bin/bash -eu

source_root=$(python -c "from os import path; print(path.abspath(path.join(path.dirname('$0'), '../../..')))")
test_dir="${source_root}/tests/reports/unit"

rm -rf "${test_dir}"
mkdir -p "${test_dir}/data"

export COVERAGE_FILE="${test_dir}/data/coverage"

cd "${source_root}"
py.test --cov --junit-xml="${test_dir}/junit.xml" "${source_root}/tests/unit"

coverage combine
coverage html --dir "${test_dir}/html"
coverage xml -o "${test_dir}/coverage.xml"
