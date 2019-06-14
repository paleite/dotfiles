#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly JOB_NAME=${1:-}

cd "${DIR}"
# shellcheck source=cron/.functions
source .functions

SCRIPT_PATH="${DIR}/${JOB_NAME}".sh
if [ -r "$SCRIPT_PATH" ] && [ -x "$SCRIPT_PATH" ];
then
  _title "$JOB_NAME"
  export JOB_NAME
  $SCRIPT_PATH
else
  echo "$(tput bold)Invalid cronjob '${JOB_NAME}'$(tput sgr0)

Available options are:
$(_print_shortlist)"
  exit 1
fi;
