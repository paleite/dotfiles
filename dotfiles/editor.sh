#!/bin/bash

OPTS=""
if [[ "$1" == /tmp/* ]]; then
    OPTS="--wait"
fi

/usr/local/bin/cursor ${OPTS:-} -a "$@"
