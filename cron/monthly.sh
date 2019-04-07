#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd "${DIR}"
source .functions

_exit_on_tethered
# Large directories in home:
# "${HOME}"/dev # Must be handled manually, but there's some cache dirs and node_modules-folders in here. Maybe check for oldest modified folders containing node_modules and remove the node_modules-folder
# "${HOME}"/Library # Must be handled manually, but there's some cache dirs in here
# "${HOME}"/Downloads # Must be handled manually
# "${HOME}"/.npm # Already cleaned with `npm cache clean --force`
# "${HOME}"/Dropbox # Can't be deleted
# "${HOME}"/Google Drive (patrick.eriksson.se) # Must be handled manually
# "${HOME}"/.vscode # Contains extensions, so can't be removed
# "${HOME}"/npm-packages-offline-cache
_title "brew cleanup"
brew cleanup -s
_title "brew doctor"
brew doctor
# sudo chown -R patrickaleite $(brew --prefix)/\* # Fix /usr/local not being writable
# _title "brew prune"
# brew prune # Warning: Calling 'brew prune' is deprecated! Use 'brew cleanup' instead.
_title "npm cache clean --force"
npm cache clean --force
_title "yarn cache clean"
yarn cache clean
_title "n prune"
n prune
_title "docker system prune -a"
docker system prune -a --force
_title "Prune old files in ${HOME}/.electron"
cd "${HOME}"/.electron
command ls -t | tail -n +5 | xargs -I {} trash -v "{}"
