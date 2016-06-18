#!/bin/bash -eu

source_root=$(python -c "from os import path; print(path.abspath(path.join(path.dirname('$0'), '../..')))")

export COVERAGE_FILE="${source_root}/tests/integration/.coverage/integration"

coverage combine
coverage html --dir "${source_root}/tests/integration/html-coverage"
coverage xml
coverage report
