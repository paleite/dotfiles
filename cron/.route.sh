#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly JOBNAME=${1:-.shortlist}

cd "${DIR}"
source .functions

SCRIPT_PATH="${DIR}/${JOBNAME}".sh
if [ -r "$SCRIPT_PATH" ] && [ -x "$SCRIPT_PATH" ];
then
  _title "$JOBNAME"
  $SCRIPT_PATH
else
echo "$(tput bold)Invalid cronjob '${JOBNAME}'$(tput sgr0)

Available options are:
$(${DIR}/.shortlist.sh)"
  exit 1
fi;
