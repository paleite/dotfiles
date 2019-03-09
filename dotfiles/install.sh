#!/usr/bin/env bash

set -e
set -x

echo "Running install.sh"

OS=$(uname)
# Portable TMPDIR
# https://unix.stackexchange.com/a/174818
TMPDIR=$(dirname $(mktemp -u))

# Install Xcode Command Line Tools (adds git, make, etc. needed for homebrew)
echo "Installing Xcode Command Line Tools…"
sudo softwareupdate -i -a
xcode-select --install

# Add .extra file if it doesn't exist
[ -e "${HOME}/.extra" ] || echo "'${HOME}/.extra' doesn't exist" # touch "${HOME}/.extra"

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

if [ "${OS}" == "Darwin" ]; then
  # Change default settings
  echo "Changing default settings…"
  sh ./.macos

  # Install software
  echo "Installing software…"
  # Note: This is only to install homebrew. NOT to install its Brewfile
  sh ./.brew
else
  # curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

  # # Install n
  # # NB: Should ideally be installed from a package manager like brew
  # yarn global add n
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

if [ "${OS}" == "Darwin" ]; then
  # Install Homebrew kegs and Mac App Store apps
  echo "Installing Homebrew kegs and Mac App Store apps…"
  # brew bundle

  # # `svgo` currently requires `node`, but we install it through `n`, so it's not needed anymore
  # brew uninstall --ignore-dependencies node
fi

# Configure yarn
echo "Configuring yarn…"
# # Save exact version when adding
# yarn config set save-exact true
# # Mirror packages offline
# yarn config set yarn-offline-mirror "${TMPDIR}/npm-packages-offline-mirror"
# yarn config set yarn-offline-mirror-pruning true

################################################################################
# Misc software
################################################################################

# - php? https://php-osx.liip.ch
