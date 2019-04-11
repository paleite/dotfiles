#!/usr/bin/env bash

# [[ "${DEBUG}" == 'true' ]] &&
set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

IFS=$'\n'
_FILES=(".failure" ".hello")
IFS=$'\n'
_RES=$(cat <<< "${_FILES[*]}" | grep '.' | xargs -I{} trash -v "{}" 2>&1 || true)
cat <<< "${_RES[*]}" | grep 'path' --color=always
# trash failure || exit 123 2>&1 | grep 'failure' || true
# trash failure 2>&1 || true | grep 'path' | grep 'does'

