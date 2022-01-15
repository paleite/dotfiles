#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

echo "$(tput bold)dotfiles export-brewfile$(tput sgr0)"

brew bundle dump --global --force --describe --verbose
