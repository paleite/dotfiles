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
cd "${HOME}"/dev/monitor-trustly.com
NODE_NO_WARNINGS=1 npx babel-node src/index.js --reset
NODE_NO_WARNINGS=1 npx babel-node src/index.js --quiet

cd "${HOME}"/dev/docpad-trustly.com/

#### Updated to latest version
git checkout HEAD^
git checkout -f master
git reset --hard
git clean -df
git pull || true

#### Generate the site
yarn run build
alert
