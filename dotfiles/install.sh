#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly OS=$(uname)
readonly TMPDIR=$(dirname $(mktemp -u)) # Portable TMPDIR: https://unix.stackexchange.com/a/174818
cd "$DIR"

echo "Running install.sh"
echo ""

# Add .extra file if it doesn't exist
[ -e "${HOME}/.extra" ] || touch "${HOME}/.extra"

################################################################################
# macOS
# TODO:
# - Check for macOS first, otherwise the tests will fail
# - mathias bynens macos dotfiles/script
# - brewfile / mas
# - keychain
# - icloud setup
# - find my mac
# - hot corners
# - compare .macos with my current settings
# - defaults write
#   - spacer tiles
#   - expand save
#   - turn off smart quotes, auto caps, autocorrect
#   - dark mode
################################################################################

if [ "${OS}" == "Darwin" ]
then
  # Change default settings
  echo "Changing default settings…"
  sh ./.macos

  # Install software
  echo "Installing software…"
  # Note: This is only to install homebrew. NOT to install its Brewfile
  sh ./.brew
fi

################################################################################
# Software / global packages
# TODO:
# - brew (Brewfile)
# - yarn (global package.json)
# - gem
# - composer
# - docker?
# - cask install dropbox?
# - which apps are installed?
################################################################################

if [ "${OS}" == "Darwin" ]
then
  # Install Homebrew kegs and Mac App Store apps
  echo "Installing Homebrew kegs and Mac App Store apps…"
  brew bundle

  # # `svgo` currently requires `node`, but we install it through `n`, so it's not needed anymore
  brew uninstall --ignore-dependencies node

  echo ""
fi

# Install VSCode extensions
./import-vscode-extensions.sh

# Configure yarn
echo "Configuring yarn…"
# TODO: Move to function
# Save exact version when adding
yarn config set save-exact true
# Mirror packages offline
yarn config set yarn-offline-mirror "${TMPDIR}/npm-packages-offline-mirror"
yarn config set yarn-offline-mirror-pruning true

echo ""

################################################################################
# Misc software
################################################################################

echo "Installing misc software…"

if [ "${OS}" == "Darwin" ]
then
  echo "  Installing PHP 7.3"
  curl -s https://php-osx.liip.ch/install.sh | bash -s force 7.3
fi

echo ""

################################################################################
# Cronjobs
################################################################################

echo "Installing cronjobs…"

cat ./crontab
crontab ./crontab

echo ""

echo "Restarting Dock…"

if [ "${OS}" == "Darwin" ]
then
  killall Dock
fi

echo ""
