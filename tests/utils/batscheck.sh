#!/bin/bash -eu

/usr/lib/bats/bats-preprocess < "$1" \
    | sed 's|^#!/usr/bin/env bats.*$|#!/bin/bash\n\nexport output=\nexport status=|' \
    | shellcheck -
