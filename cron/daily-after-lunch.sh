#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd "${DIR}"
# shellcheck source=cron/.functions
source .functions
source ~/.functions

set -o verbose

_title "MacDown-Template"
cd "${HOME}"/dev/MacDown-Template
yarn run build

_exit_on_tethered

_title "mas upgrade"
mas upgrade

_title "n lts"
n lts

_title "yarn global list outdated"
# npm i -g $(npx -p npm-check-updates ncu -g | awk -F" " '{print $1}' | tr '\n' ' ')
# ~/.config/yarn/global/package.json
yarn global list outdated

_title "yarn global upgrade --latest"
yarn global upgrade --latest

_title "brew update"
brew update

_title "brew upgrade"
brew upgrade &

_title "brew cask upgrade"
brew cask upgrade &

_title "pip-review --local --auto"
pip-review --local --auto
