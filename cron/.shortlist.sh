#!/usr/bin/env bash

# readonly ENVIRONMENT="${ENVIRONMENT:-undefined}"
[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd "${DIR}"
SHORTLIST=()
for i in *.sh;
do
  SCRIPT_PATH="${i}"
  if [ -r "$SCRIPT_PATH" ] && [ -x "$SCRIPT_PATH" ];
  then
    SHORTLIST+=("${i%.sh}")
  fi
done

echo ${SHORTLIST[*]}
