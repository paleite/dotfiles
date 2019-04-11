#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

git clone --depth 1 --bare https://github.com/paleite/dotfiles.git "${HOME}/.dotfiles/" || git pull

cd "${HOME}"

if .f checkout; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  mkdir -p .dotfiles-backup
  readonly _FILES_TO_BACKUP=$(.f checkout 2>&1 || true)
  cat <<< "${_FILES_TO_BACKUP[*]}" | grep -E "^\s+" | awk '{print $1}' | xargs -I{} mv -v "{}" ".dotfiles-backup/{}"
fi;
.f checkout
.f config status.showUntrackedFiles no
