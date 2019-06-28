#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd "${DIR}"
# shellcheck source=cron/.functions
source .functions

set -o verbose

_exit_on_tethered
cd "${HOME}"/dev/jekyll-trustly.com/

#### Updated to latest version
git checkout HEAD^
git checkout -f master
git reset --hard
git pull || true

### Update dependencies
yarn install

###
git add *.lock
git commit -S -m 'Update lockfiles' && open -a /Applications/SourceTree.app . || true

#### Generate the site
yarn run production || yarn run production

###
git add .
git add -f ./dist/
git reset './dist/**/.*'
git commit -S -m 'Generate production' && open -a /Applications/SourceTree.app . || true
alert
