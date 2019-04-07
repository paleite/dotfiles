#!/usr/bin/env bash

# shellcheck source=.profile
source "${HOME}"/.profile

# readonly ENVIRONMENT="${ENVIRONMENT:-undefined}"
# [[ "${ENVIRONMENT}" == 'cron' ]] && set -o xtrace
[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases

# printf "CMDLINE:\t'%s'\n" $@
# printf "PATH:\t\t'%s'\n" $PATH

# # DEBUG=true # todo: remove after debugging

# export DEBUG
source "${HOME}"/cron/.functions
_run_cronjob ${HOME}/cron/.route.sh $@
