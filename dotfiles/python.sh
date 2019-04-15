#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

echo "$(tput bold)dotfiles python$(tput sgr0)"

pip install pip-review
pip install ntfy
