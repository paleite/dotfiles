#!/bin/bash

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

# TODO:
# Either do these steps manually or script them.
#
# oh-my-zsh:
# - .oh-my-zsh/custom is in the repo, which prevents oh-my-zsh from installing automatically
# - When installing oh-my-zsh, make sure to do something like `sudo echo "$(which zsh)" >> /etc/shells` in order to be
#   able to do `chsh -s $(which zsh)`. For more info, see https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
#
# SSH
# - .ssh-permissions need to be fixed in the postinstall
#
# Ruby
# - When installing bundler `gem install bundler`, it seems ruby doesn't have the permissions to write to its path, so
#   you need to chown -R "$(whoami)" FOLDERNAME it
#
# yarn link
# - post install: `cron-gmail` and `is-tethered` need to be linked (yarn link)
#
# GnuPG
# Make sure the folder+contents belong to user:
# chown -R $(whoami) ~/.gnupg/
# Fix access rights for .gnupg and subfolders:
# - fix permissions on gpg-dir: gpg: WARNING: unsafe permissions on homedir '~/.gnupg'
# find ~/.gnupg -type f -exec chmod 600 {} \;
# find ~/.gnupg -type d -exec chmod 700 {} \;

echo "$(tput bold)dotfiles install$(tput sgr0)"

readonly DIR="${HOME}/dotfiles/"
readonly OS=$(/usr/bin/uname)
# Portable TMPDIR: https://unix.stackexchange.com/a/174818
readonly TMPDIR=$(/usr/bin/dirname "$(/usr/bin/mktemp -u)")
mkdir -p "$DIR"
cd "$DIR"

# Ask for the administrator password upfront
sudo --validate

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
  sudo --non-interactive true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

################################################################################
# macOS
# TODO:
# - keychain
# - icloud setup
# - find my mac
################################################################################

if [ "${OS}" == "Darwin" ]; then
  # Install software (e.g. git, make, etc.)
  # ./xcode-install.sh
  /bin/sh -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/paleite/dotfiles/next/dotfiles/xcode-install.sh)"
fi

/bin/sh -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/paleite/dotfiles/next/dotfiles/clone.sh)"

if [ "${OS}" == "Darwin" ]; then
  # Change default settings
  ./macos.sh

  # Install oh-my-zsh
  ZSH=${ZSH:-${HOME}/.oh-my-zsh}

  if ! [ -d "$ZSH" ]; then
    ./oh-my-zsh.sh
  fi

  # Note: This is only to install homebrew. NOT to install its Brewfile
  echo "(Brew) Installing Homebrew"
  if ! brew --version >/dev/null; then
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
  yarn config set init-author-url "https://github.com/paleite"
  yarn config set init-private true

  readonly PHP_VERSION="7.2"
  echo "(PHP) Installing PHP ${PHP_VERSION}"
  if ! php --version | grep "^PHP ${PHP_VERSION}" >/dev/null; then
    /usr/bin/curl --silent https://php-osx.liip.ch/install.sh | /bin/bash -s force "${PHP_VERSION}"
  fi

  echo "(Ruby) Installing latest ruby dev"
  readonly RUBY_VERSION=$(
    rbenv install --list |
      grep --regexp='\s\d\.\d\.\d-dev' |
      tail -n1 |
      /usr/bin/sed 's/^ *//' |
      /usr/bin/tr -d '\n'
  )

  if ! rbenv version | grep --regexp="^${RUBY_VERSION}" >/dev/null; then
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

if [ "${OS}" == "Darwin" ]; then
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
echo "✨ Done."
