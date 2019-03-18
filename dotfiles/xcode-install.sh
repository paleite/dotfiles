#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

# Install Xcode Command Line Tools (adds git, make, etc. needed for homebrew)
echo "Installing Xcode Command Line Tools (xcode-select)…"
are_xcode_command_line_tools_installed() {
    xcode-select --print-path &> /dev/null
}

install_xcode_command_line_tools() {
  /usr/bin/touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  PROD=$( \
    /usr/sbin/softwareupdate -l | \
    grep --color=never -B 1 -E 'Command Line (Developer|Tools)' | \
    awk -F'*' '/^ +\\*/ {print $2}' | \
    grep '#{clt_macos_version}' | \
    sort -V | \
    sed 's/^ *//' | \
    tail -n1 \
  )

  $DRY_RUN || sudo /usr/sbin/softwareupdate -v -i "$PROD"
  $DRY_RUN || sudo /bin/rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  $DRY_RUN || sudo /usr/bin/xcode-select --switch /Library/Developer/CommandLineTools

  # Fallback solution
  ##############################################################################
  # If necessary, prompt user to install
  # the `Xcode Command Line Tools`.

  # $DRY_RUN || sudo softwareupdate -i -a
  # $DRY_RUN || xcode-select --install &> /dev/null

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
