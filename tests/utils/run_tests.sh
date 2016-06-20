#!/bin/bash -eu

source_root=$(python -c "from os import path; print(path.abspath(path.join(path.dirname('$0'), '../..')))")
test_dir="${source_root}/tests/utils/tests"

"${test_dir}/shellcheck.sh"
"${test_dir}/unit.sh"
"${test_dir}/integration.sh"
