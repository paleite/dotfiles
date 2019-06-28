#!/usr/bin/env bash

# shellcheck source=.profile
source "${HOME}"/.profile

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly ENVIRONMENT="${ENVIRONMENT:-shell}"
export ENVIRONMENT

# shellcheck source=cron/.functions
source "${HOME}"/cron/.functions
_run_cronjob "${HOME}"/cron/.route.sh "$@" | cron-gmail --subject "[Cron] $*" --tag "cron $*"
