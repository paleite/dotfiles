#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# readonly DIR="$(cd "$(/usr/bin/dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly DIR="${HOME}/dotfiles/"
.f status
readonly OS=$(/usr/bin/uname)
readonly TMPDIR=$(/usr/bin/dirname "$(/usr/bin/mktemp -u)") # Portable TMPDIR: https://unix.stackexchange.com/a/174818
cd "$DIR"

################################################################################
# macOS
# TODO:
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
  ./macos.sh

  # Install software (e.g. git, make, etc.)
  ./xcode-install.sh

  # Note: This is only to install homebrew. NOT to install its Brewfile
  ./brew.sh
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


################################################################################
# Misc software
################################################################################

echo "Installing misc software…"

if [ "${OS}" == "Darwin" ]
then
  echo "Installing PHP 7.3"
  /usr/bin/curl -s https://php-osx.liip.ch/install.sh | /bin/bash -s force 7.3
fi


################################################################################
# Cronjobs
################################################################################

echo "Installing cronjobs…"

cat ./crontab
crontab ./crontab

# Create .extra-file
[ -e "${HOME}/.extra" ] || touch "${HOME}/.extra"

echo "Restarting Dock…"

if [ "${OS}" == "Darwin" ]
then
  killall Dock
fi

