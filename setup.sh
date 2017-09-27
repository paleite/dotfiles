################################################################################
# Install                                                                      #
################################################################################

# Homebrew
sh brew.sh

# Node
n latest

# NPM global packages
sh npm.sh

# Dock spacer-tiles x 5
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
killall Dock

# Mac App Store
sh mas.sh

# Sketch
sh sketch.sh

# SublimeText
# Sourcetree
# Skype
# Adium
# Whatsapp
# Postgres.app
# Chrome Canary
# ImageOptim
# JPEGmini
# Spectacle
# Flux
# Dropbox
# Google Backup & Sync

################################################################################
# Defaults                                                                     #
################################################################################

## TextEdit
# Use Plain Text Mode as Default
defaults write com.apple.TextEdit RichText -int 0

## Sketch
# Export Compact SVGs
defaults write com.bohemiancoding.sketch3 exportCompactSVG -bool yes

## Finder
# Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Show Status Bar
defaults write com.apple.finder ShowStatusBar -bool true

# Turn Off System Sleep Completely
sudo systemsetup -setcomputersleep Never

# Automatic Restart on System Freeze
sudo systemsetup -setrestartfreeze on

# Auto-Correct Disable
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Key Repeat Rate
defaults write -g KeyRepeat -int 0.02

# Generate 20 char password
LC_ALL=C tr -dc "[:alpha:][:alnum:]" < /dev/urandom | head -c 256 | pbcopy

# Enable Screensaver Password
defaults write com.apple.screensaver askForPassword -int 1

# Enable FileVault Service
sudo fdesetup enable
