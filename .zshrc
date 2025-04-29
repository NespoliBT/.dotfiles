##########################
##   Nespoli's .zshrc   ##
##########################

#
## Antigen configs 🔥
source ~/.antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting

#
## Theme
antigen theme af-magic

antigen apply

#
## Exports
export PATH=$HOME/.local/share/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
export GEM_HOME="$HOME/.gem"
export NVM_DIR="$HOME/.nvm"

export TERM=xterm
export VISUAL=code
export EDITOR=vim

#
## NVM Configs
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ -d "/usr/share/nvm" ]; then
  source /usr/share/nvm/nvm.sh
  source /usr/share/nvm/bash_completion
  source /usr/share/nvm/install-nvm-exec
fi

#
## Set color theme
COLORSCHEMEDIR="$HOME/.cache/wal/"
if [ -d "$COLORSCHEMEDIR" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  cat "$COLORSCHEMEDIR/sequences"  
fi

#
## Start screen
GITDIR="./.git/"
if [ -d "$GITDIR" ]; then
  onefetch
else
  pfetch
fi

#
## Aliases
alias ls="exa --icons"
alias cat="bat -p"
alias ip="ip -c"
alias note="cd ~/note&&vim"
alias ioquandosicasa="sshuttle -r casaos@nespolibt.duckdns.org 0.0.0.0/0"

#
## Autorun Hyprland
#if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#    dbus-run-session Hyprland
#fi
