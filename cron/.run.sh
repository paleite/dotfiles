#!/usr/bin/env bash

# shellcheck source=.profile
source "${HOME}"/.profile

export _COLOR=$(tput setaf 246)
export _RESET=$(tput sgr0)
export PS4=$'${_COLOR}# ~/${BASH_SOURCE[0]##~/}:${LINENO}\n${BASH_COMMAND}${_RESET}\n'
# [[ "${DEBUG:-}" == 'true' ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail

readonly ENVIRONMENT="${ENVIRONMENT:-shell}"
export ENVIRONMENT

# shellcheck source=cron/.functions
source "${HOME}"/cron/.functions
_run_cronjob "${HOME}"/cron/.route.sh "$@" | cron-gmail --subject "[Cron] $*" --tag "cron $*"
