#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

echo "$(tput bold)dotfiles export-current-machine$(tput sgr0)"

readonly DIR="${HOME}/dotfiles/"
readonly OS=$(/usr/bin/uname)
# readonly TMPDIR=$(/usr/bin/dirname "$(/usr/bin/mktemp -u)") # Portable TMPDIR: https://unix.stackexchange.com/a/174818
cd "$DIR"

echo "Brew: Dump Brewfile"
./export-brewfile.sh

echo "Mackup: Backup"
mackup backup --force --verbose                                     # Backup current setup to Dropbox (creates symlinks to the Dropbox-folder)
# mackup restore --force --verbose # Install on a new computer (restore symlinks from previous computer)
# mackup uninstall --force --verbose # Restore files from symlinks (Uninstall Mackup)
/bin/chmod +x "${HOME}"/*.sh "${HOME}"/dev/*.sh "${HOME}"/cron/*.sh # Fix Mackup's permissions bug

echo "VS Code: Export extensions"
./export-vscode-extensions.sh

# Sync dotfiles-repo to Dropbox
# echo "Sync dotfiles to Dropbox (DRY RUN)"
# set -x
# rsync --dry-run -av --delete "${HOME}/.dotfiles/" "${HOME}/Dropbox/.dotfiles"
