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

export ZSH="$HOME/.oh-my-zsh"

export TERM=xterm
export VISUAL=code
export EDITOR=nvim

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
alias ioquandosicasa="sshuttle -r casaos@nespolibt.duckdns.org 0.0.0.0/0"
alias twitch-live="nix run nixpkgs#wayvnc 0.0.0.0"
alias flake-template='f() {
  cp ~/.dotfiles/nixos/flake_templates/$1.nix ./flake.nix
};f'

## Autorun Hyprland
#if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#    dbus-run-session Hyprland
#fi
