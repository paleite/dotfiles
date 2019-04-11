#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

readonly F="${HOME}/$1"; \

if [[ -e $F ]]; then
  echo "$(tput bold)$(tput setaf 1)$F already exists.$(tput sgr0)"
  exit 1
fi

echo "Creating ${F}";

touch "${F}";
.f add "${F}";
code "${F}";
