#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd "${DIR}"
# shellcheck source=cron/.functions
source .functions
source ~/.functions

# set -o verbose

_exit_on_tethered

PROJECTS_LIST_FILE="${HOME}"/dev/.projects
cd $(dirname "${PROJECTS_LIST_FILE}")

for PROJECT_DIR in $(grep -E '^[^#]' <"${PROJECTS_LIST_FILE}"); do
  check_upstream "${PROJECT_DIR}" &
done <$PROJECTS_LIST_FILE
