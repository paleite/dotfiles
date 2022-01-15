#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

cd "${HOME}"

echo "$(tput bold)dotfiles clone$(tput sgr0)"

git clone --depth 1 --bare https://github.com/paleite/dotfiles.git "${HOME}/.dotfiles/" >/dev/null 2>&1 || .f pull

if .f checkout; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dot files."
  mkdir -p .dotfiles-backup
  readonly _FILES_TO_BACKUP=$(.f checkout 2>&1 || true)
  cat <<<"${_FILES_TO_BACKUP[*]}" | grep --regexp="^\s+." | awk '{print $1}' | xargs -I{} mv -v "{}" ".dotfiles-backup/{}"
fi
.f checkout
.f config status.showUntrackedFiles no
