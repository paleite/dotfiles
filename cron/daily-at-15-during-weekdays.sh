#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly DIR

cd "${DIR}"
# shellcheck source=./.functions
source .functions

set -o verbose

# _title "Update list of versions"
# cat ~/.config/yarn/global/package.json > ~/versions-of-installed-apps-and-modules.txt;
# brew list --versions >> ~/versions-of-installed-apps-and-modules.txt;

_title "Update global Brewfile"
"${HOME}/dotfiles/export-brewfile.sh"
