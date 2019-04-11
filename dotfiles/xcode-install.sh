#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

# Inspirations:
# https://raw.githubusercontent.com/alrra/dotfiles/master/src/os/install/macos/xcode.sh

# Install Xcode Command Line Tools (adds git, make, etc. needed for homebrew)
echo "Installing Xcode Command Line Tools (xcode-select)..."
are_xcode_command_line_tools_installed() {
    xcode-select --print-path &> /dev/null
}

install_xcode_command_line_tools() {
  /usr/bin/touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

  # Get the product name for Command Line Tools:
  # awk with delimiter '*'
  # sed removes leading space
  # tr removes trailing newline
  PROD=$( \
    sudo /usr/sbin/softwareupdate --list | \
    /usr/bin/grep -E '^ +\* Command Line Tools' | \
    /usr/bin/awk -F'*' '/^ +\\*/ {print $2}' | \
    /usr/bin/sed 's/^ *//' | \
    /usr/bin/tr -d '\n' || \
    true \
  )

  if [[ "$PROD" != "" ]]
  then
    sudo /usr/sbin/softwareupdate --verbose --install "${PROD}"
  fi

  sudo /usr/bin/xcode-select --switch /Library/Developer/CommandLineTools
  sudo /bin/rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

  # Fallback solution (UNTESTED)
  ##############################################################################
  # If necessary, prompt user to install
  # the `Xcode Command Line Tools`.

  # sudo softwareupdate -i -a
  # xcode-select --install &> /dev/null

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Wait until the `Xcode Command Line Tools` are installed.

  # execute \
  #     "until are_xcode_command_line_tools_installed; do \
  #         sleep 5; \
  #      done" \
  #     "Xcode Command Line Tools"
  ##############################################################################
  # END Fallback solution
}

are_xcode_command_line_tools_installed || install_xcode_command_line_tools
