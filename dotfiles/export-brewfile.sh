#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

echo "$(tput bold)dotfiles export-brewfile$(tput sgr0)"

# Homebrew could be too outdated for `brew bundle`, so we need to update it
# before running `brew bundle dump`
brew update
brew bundle dump --global --force --describe --verbose
