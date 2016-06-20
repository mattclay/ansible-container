#!/usr/bin/env bats

cd "${BATS_TEST_DIRNAME}"

@test "invalid command fails" {
    run ansible-container invalid
    [ "${status}" -eq 2 ]
    [[ "${output}" = *"ansible-container: error: argument subcommand: invalid choice: 'invalid'"* ]]
}

@test "no command shows help" {
    run ansible-container
    [ "${status}" -eq 2 ]
    [[ "${output}" = *"ansible-container: error: too few arguments"* ]]
}

@test "help command shows help" {
    run ansible-container help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container"* ]]
}

@test "help option shows help" {
    run ansible-container --help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container"* ]]
}

@test "help option shows help for run command" {
    run ansible-container run --help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container run"* ]]
}

@test "help option shows help for help command" {
    run ansible-container help --help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container help"* ]]
}

@test "help option shows help for shipit command" {
    run ansible-container shipit --help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container shipit"* ]]
}

@test "help option shows help for init command" {
    run ansible-container init --help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container init"* ]]
}

@test "help option shows help for build command" {
    run ansible-container build --help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container build"* ]]
}

@test "help option shows help for push command" {
    run ansible-container push --help
    [ "${status}" -eq 0 ]
    [[ "${output}" = *"usage: ansible-container push"* ]]
}

@test "run in uninitialized directory fails" {
    run ansible-container run
    [ "${status}" -eq 1 ]
    [[ "${output}" = *"No Ansible Container project data found"* ]]
}

@test "shipit in uninitialized directory fails" {
    run ansible-container shipit
    [ "${status}" -eq 1 ]
    [[ "${output}" = *"No such file or directory"* ]]
}

@test "init empty directory" {
    rm -rf projects/init
    mkdir projects/init
    cd projects/init && ansible-container init
}
