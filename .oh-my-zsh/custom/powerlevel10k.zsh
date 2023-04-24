# Init
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
source "${HOME}"/.p10k.zsh

# Left and right prompt elements
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-remotebranch git-tagname)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status command_execution_time dir dir_writable vcs ssh)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(os_icon command_execution_time background_jobs direnv asdf virtualenv anaconda pyenv goenv nodenv nvm nodeenv rbenv rvm fvm luaenv jenv plenv perlbrew phpenv scalaenv haskell_stack kubecontext terraform aws aws_eb_env azure gcloud google_app_cred toolbox context nordvpn ranger nnn lf xplr vim_shell midnight_commander nix_shell vi_mode todo timewarrior taskwarrior load time battery)

# Options
POWERLEVEL9K_RAM_ELEMENTS=(ram_free)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# Colors
POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(red1 orangered1 darkorange orange1 gold1 yellow1 yellow2 greenyellow chartreuse1 chartreuse2 green1)
POWERLEVEL9K_BATTERY_LEVEL_FOREGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="none"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="yellow"
POWERLEVEL9K_DIR_HOME_BACKGROUND="yellow"
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="yellow"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
POWERLEVEL9K_OS_ICON_BACKGROUND="grey39"
POWERLEVEL9K_OS_ICON_FOREGROUND="white"
POWERLEVEL9K_RAM_BACKGROUND="grey39"
POWERLEVEL9K_RAM_FOREGROUND="white"
POWERLEVEL9K_TIME_BACKGROUND="grey39"
POWERLEVEL9K_TIME_FOREGROUND="white"
POWERLEVEL9K_STATUS_BACKGROUND="none"
POWERLEVEL9K_STATUS_FOREGROUND="green"
