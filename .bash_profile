# Custom PS1
export PS1="\[\033[01;34m\] \W \[\033[31m\]\$(parse_git_branch) \[\033[00m\]$\[\033[00m\] "

# Improve globbing
shopt -s extglob
shopt -s dotglob

# Improve Bash Tab-behavior
bind 'TAB':menu-complete # Automatically take a valid value

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
