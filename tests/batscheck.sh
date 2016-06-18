#!/bin/bash -eu

/usr/lib/bats/bats-preprocess < "$1" \
    | sed 's|^#!/usr/bin/env bats$|#!/usr/bin/bash|' \
    | shellcheck -
