#!/usr/bin/env bash

# shellcheck source=.profile
source "${HOME}"/.profile

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases

source "${HOME}"/cron/.functions
_run_cronjob "${HOME}"/cron/.route.sh "$@" | cron-gmail --subject "$@" --tag "cron $@"
