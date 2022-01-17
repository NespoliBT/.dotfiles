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

source /Users/davide.nespoli/.oh-my-zsh/themes/headline.zsh-theme

antigen apply

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
clear&&pfetch
