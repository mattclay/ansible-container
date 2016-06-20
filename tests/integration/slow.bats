#!/usr/bin/env bats

cd "${BATS_TEST_DIRNAME}"

@test "build minimal docker container" {
    cd projects/minimal && ansible-container build
}

@test "run minimal docker container" {
    cd projects/minimal && ansible-container run
}

@test "shipit minimal docker container" {
    run bash -c 'cd projects/minimal && ansible-container shipit'
    [ "${status}" -eq 1 ]
}
