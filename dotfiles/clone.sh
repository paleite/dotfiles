#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

git clone --depth 1 --bare https://github.com/paleite/dotfiles.git "${HOME}/.dotfiles/"

cd "${HOME}"
mkdir -p .dotfiles-backup

if .f checkout; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  .f checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv -v {} .dotfiles-backup/{}
fi;
.f checkout
.f config status.showUntrackedFiles no
