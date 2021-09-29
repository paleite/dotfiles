#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly DIR

cd "${DIR}"
# shellcheck source=../.profile
source "${HOME}"/.profile

_COLOR=$(tput setaf 246)
export _COLOR
_RESET=$(tput sgr0)
export _RESET
PS4=$'${_COLOR}# ~/${BASH_SOURCE[0]##~/}:${LINENO}\n${BASH_COMMAND}${_RESET}\n'
export PS4

# [[ "${DEBUG:-}" == 'true' ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail

ENVIRONMENT="${ENVIRONMENT:-shell}"
readonly ENVIRONMENT
export ENVIRONMENT

# shellcheck source=./.functions
source "${HOME}"/cron/.functions
_run_cronjob "${HOME}"/cron/.route.sh "$@" | cron-gmail --subject "[Cron] $*" --tag "cron $*"
