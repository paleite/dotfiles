#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

echo "$(tput bold)dotfiles post-install$(tput sgr0)"

echo "$(tput setaf 3)warning$(tput sgr0) Please ensure Dropbox has finished syncing before continuing."
read -n 1 -s -r -p "Press any key to continue."
echo ""

# Restore settings using `mackup restore`
mackup restore --force --verbose

# Ensure .extra-file
[ -e "${HOME}/.extra" ] || touch "${HOME}/.extra"

# Ensure control-directory for .ssh-connections
mkdir -p "${HOME}/.ssh/control"

# Restore permissions in scripts
/bin/chmod +x "${HOME}"/*.sh "${HOME}"/dev/*.sh "${HOME}"/cron/*.sh

# Restart Dock
if [ "${OS}" == "Darwin" ]
then
  killall Dock
fi
