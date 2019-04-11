#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

readonly DIR="${HOME}/dotfiles/"
readonly OS=$(/usr/bin/uname)
# Portable TMPDIR: https://unix.stackexchange.com/a/174818
readonly TMPDIR=$(/usr/bin/dirname "$(/usr/bin/mktemp -u)")
mkdir -p "$DIR"
cd "$DIR"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################################################################################
# macOS
# TODO:
# - keychain
# - icloud setup
# - find my mac
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
  echo "(Brew) Installing Homebrew"
  ./brew.sh

  echo "(Node.js) Installing Node.js and Yarn"
  brew install n yarn
  # Install latest Node.js
  n latest
  # Configure yarn
  #€ Save exact version when adding
  yarn config set save-exact true
  #€ Mirror packages offline
  yarn config set yarn-offline-mirror "${TMPDIR}/npm-packages-offline-mirror"
  yarn config set yarn-offline-mirror-pruning true

  echo "(PHP) Installing PHP 7.3"
  /usr/bin/curl -s https://php-osx.liip.ch/install.sh | /bin/bash -s force 7.3

  echo "(Ruby) Installing Bundler"
  gem install bundler
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
  echo "(Brew) Installing Homebrew kegs and Mac App Store apps..."
  brew bundle

  echo "(Node.js) Installing global packages with Yarn"
  yarn global upgrade

  echo "(PHP) Installing global packages with Composer"
  composer global install

  echo "(Ruby) Installing global gems with Bundler..."
  bundle install --system --gemfile Gemfile
fi

# Install VSCode extensions
./import-vscode-extensions.sh

################################################################################
# Cronjobs
################################################################################

echo "Installing cronjobs..."

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
# Once Dropbox has synced:
# - Restore settings using `mackup restore`
# - Restore permissions in scripts by running /bin/chmod +x "${HOME}"/*.sh "${HOME}"/dev/*.sh "${HOME}"/cron/*.sh
# - Restore fonts
# rsync -rtuv  ~/Library/Fonts/* ~/Dropbox/Mackup/Library/Fonts/
# rsync -rtuv  ~/Dropbox/Mackup/Library/Fonts/* ~/Library/Fonts/
