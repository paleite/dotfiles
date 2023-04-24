#!/bin/bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ${HOME}/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# I've replaced the extra call to "brew --prefix" with the actual path, so the shell starts faster
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi
[[ $BASH ]] && [[ -s /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion

# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # Very slow and dangerous. Should rbenv ever be compromised, this will grant it access to inject code.

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
