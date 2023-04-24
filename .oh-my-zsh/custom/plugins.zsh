# Load plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

zstyle ':omz:plugins:nvm' autoload true
plugins=(git wd yarn aws zsh-better-npm-completion yarn-autocompletions nvm)

for plugin ($plugins); do
  if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
  else
    echo "[oh-my-zsh] plugin '$plugin' not found"
  fi
done
