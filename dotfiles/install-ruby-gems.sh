#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

gem install bundler
bundle install --system --gemfile "${HOME}"/dotfiles/Gemfile
