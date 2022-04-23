# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/share/bin:/usr/local/bin:$PATH

export VISUAL=code
export EDITOR=vim

# Path to my oh-my-zsh install
export ZSH="$HOME/.oh-my-zsh"

# Antigen configs 🔥
# Downloaded via: curl -L git.io/antigen > antigen.zsh
source ~/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Autocomplete
antigen bundle git
antigen bundle pip

antigen bundle command-not-found

antigen bundle z # Jump around dirs

antigen bundle zsh-users/zsh-syntax-highlighting # Fish like highlight

# Theme
antigen theme af-magic 

antigen apply

# Exports
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
export GEM_HOME="$HOME/.gem"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

COLORSCHEMEDIR="$HOME/.cache/wal/"
if [ -d "$COLORSCHEMEDIR" ]; then
  cat "$COLORSCHEMEDIR/sequences"  
fi

clear

GITDIR="./.git/"
if [ -d "$GITDIR" ]; then
  onefetch
else
  pfetch
fi

# Aliases
alias ls="exa --icons"
alias cat="bat"

export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
