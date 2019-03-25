#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# readonly DIR="$(cd "$(/usr/bin/dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly DIR="${HOME}/dotfiles/"
readonly OS=$(/usr/bin/uname)
readonly TMPDIR=$(/usr/bin/dirname "$(/usr/bin/mktemp -u)") # Portable TMPDIR: https://unix.stackexchange.com/a/174818
cd "$DIR"

################################################################################
# macOS
# TODO:
# - keychain
# - icloud setup
# - find my mac
# - defaults write
#   - spacer tiles
#   - expand save
#   - turn off smart quotes, auto caps, autocorrect
#   - dark mode
################################################################################

if [ "${OS}" == "Darwin" ]
then
  # Install software (e.g. git, make, etc.)
  # ./xcode-install.sh
  /bin/sh -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/paleite/dotfiles/next/dotfiles/xcode-install.sh)"
fi

/bin/sh -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/paleite/dotfiles/next/dotfiles/clone.sh)"

if [ "${OS}" == "Darwin" ]
then
  # Change default settings
  ./macos.sh

  # Install oh-my-zsh
  ./oh-my-zsh.sh

  # Note: This is only to install homebrew. NOT to install its Brewfile
  ./brew.sh
fi

################################################################################
# Software / global packages
# TODO:
# - yarn (global package.json) clone required
# - gem
# - composer
# - docker?
# - cask install dropbox?
# - which apps are installed?
################################################################################

if [ "${OS}" == "Darwin" ]
then
  # Install Homebrew kegs and Mac App Store apps
  echo "Installing Homebrew kegs and Mac App Store apps..."
  brew bundle
fi

# Install VSCode extensions
./import-vscode-extensions.sh

# Configure yarn
echo "Configuring yarn..."
# Save exact version when adding
yarn config set save-exact true
# Mirror packages offline
yarn config set yarn-offline-mirror "${TMPDIR}/npm-packages-offline-mirror"
yarn config set yarn-offline-mirror-pruning true
yarn global upgrade

################################################################################
# Misc software
################################################################################

echo "Installing misc software..."

if [ "${OS}" == "Darwin" ]
then
  echo "Installing Sketch 43"
  brew cask install --force "${HOME}/dotfiles/casks/sketch43.rb"

  echo "Installing PHP 7.3"
  /usr/bin/curl -s https://php-osx.liip.ch/install.sh | /bin/bash -s force 7.3
fi


################################################################################
# Cronjobs
################################################################################

echo "Installing cronjobs..."

cat ./crontab
crontab ./crontab

# Create .extra-file
[ -e "${HOME}/.extra" ] || touch "${HOME}/.extra"

# Ensure control-directory for .ssh-connections
mkdir -p "${HOME}/.ssh/control"

echo "Restarting Dock..."

if [ "${OS}" == "Darwin" ]
then
  killall Dock
fi

# Manual steps
# Once Dropbox has synced, restore settings using `mackup restore`.
