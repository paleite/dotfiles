#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly DIR

cd "${DIR}"
# shellcheck source=./.functions
source .functions

"${HOME}/dev/dropbox-backup.sh"
