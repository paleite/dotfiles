#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly DIR
JOB_NAME=${1:-}
readonly JOB_NAME

cd "${DIR}"
# shellcheck source=./.functions
source .functions

SCRIPT_PATH="${DIR}/${JOB_NAME}".sh
readonly SCRIPT_PATH
if [ -r "$SCRIPT_PATH" ] && [ -x "$SCRIPT_PATH" ]; then
  _title "$JOB_NAME"
  export JOB_NAME
  $SCRIPT_PATH
else
  echo "$(tput bold)Invalid cronjob '${JOB_NAME}'$(tput sgr0)

Available options are:
$(_print_shortlist)"
  exit 1
fi
