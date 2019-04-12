#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

################################################################################
# Run the following command to install
# /bin/sh -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/paleite/dotfiles/next/dotfiles/install.sh)"
################################################################################

echo "$(tput bold)dotfiles install$(tput sgr0)"

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
  ZSH=${ZSH:-${HOME}/.oh-my-zsh}

  if ! [ -d "$ZSH" ];
  then
    ./oh-my-zsh.sh
  fi

  # Note: This is only to install homebrew. NOT to install its Brewfile
  echo "(Brew) Installing Homebrew"
  if ! brew -v >/dev/null;
  then
    ./brew.sh
  fi

  # Sign in to Mac App Store
  brew install mas
  mas account >/dev/null || open -a "App Store"

  # Install and start dropbox and mackup early on, so we can start syncing immediately
  brew cask install dropbox
  open -a "Dropbox"
  brew install mackup

  echo "Installing Node.js, Yarn, rbenv, composer"
  brew install n yarn rbenv composer

  # https://github.com/tj/n/issues/416
  sudo mkdir -p /usr/local/n
  sudo chown -R "$(whoami)" /usr/local/n

  # Install latest Node.js
  n latest
  # Configure yarn
  #€ Save exact version when adding
  yarn config set save-exact true
  #€ Mirror packages offline
  yarn config set yarn-offline-mirror "${TMPDIR}/npm-packages-offline-mirror"
  yarn config set yarn-offline-mirror-pruning true

  echo "(PHP) Installing PHP ${PHP_VERSION}"
  readonly PHP_VERSION="7.2"
  if ! php -v | grep "^PHP ${PHP_VERSION}" >/dev/null;
  then
    /usr/bin/curl -s https://php-osx.liip.ch/install.sh | /bin/bash -s force "${PHP_VERSION}"
  fi

  echo "(Ruby) Installing latest ruby dev"
  readonly RUBY_VERSION=$( \
    rbenv install --list | \
    grep -e '\s\d\.\d\.\d-dev' | \
    tail -n1 | \
    /usr/bin/sed 's/^ *//' | \
    /usr/bin/tr -d '\n' \
  )

  if ! rbenv version | grep -e "^${RUBY_VERSION}" >/dev/null;
  then
    # https://github.com/rbenv/ruby-build/issues/1064#issuecomment-289641586
    RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)" rbenv install "${RUBY_VERSION}"
  fi

  rbenv global "${RUBY_VERSION}"
  rbenv rehash

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
  brew bundle --global --verbose

  echo "(Node.js) Installing global packages with Yarn"
  yarn global upgrade || yarn global install

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

# Install cronjobs
crontab ./crontab

################################################################################
# Post-install
################################################################################

./post-install.sh

echo "$(tput setaf 4)info$(tput sgr0) Some of the changes require a logout/restart to take effect."
echo "✨  Done."
