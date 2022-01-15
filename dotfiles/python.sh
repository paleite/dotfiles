#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

echo "$(tput bold)dotfiles python$(tput sgr0)"

# Install pip if it isn't installed already
pip3 --version >/dev/null 2>&1 || brew reinstall python

# pip-review - Checks if pip-packages need to be updated
pip3 install pip-review
