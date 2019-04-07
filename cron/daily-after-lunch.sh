#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd "${DIR}"
source .functions

cd "${HOME}"/dev/MacDown-Template
yarn run build
_exit_on_tethered

_title "brew update && brew upgrade"
(brew update && brew upgrade)

_title "brew cask upgrade --greedy"
brew cask upgrade --greedy

_title "n latest"
n latest

_title "yarn global list outdated"
# npm i -g $(npx -p npm-check-updates ncu -g | awk -F" " '{print $1}' | tr '\n' ' ')
# ~/.config/yarn/global/package.json
yarn global list outdated

_title "yarn global upgrade --latest"
yarn global upgrade --latest

_title "pip-review --local --auto"
pip-review --local --auto
# Backup to Dropbox
cd "${HOME}"/dev

_title "dropbox-backup"
./dropbox-backup.sh
