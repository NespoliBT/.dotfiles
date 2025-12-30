{ pkgs }:

with pkgs.vscode-extensions; [
  # themes
  catppuccin.catppuccin-vsc
  catppuccin.catppuccin-vsc-icons

  # dlasagno.wal-theme

  # extensions
  vscodevim.vim
  jnoortheen.nix-ide
  esbenp.prettier-vscode
  aaron-bond.better-comments
  dbaeumer.vscode-eslint
  docker.docker
  eamodio.gitlens
  meganrogge.template-string-converter
  github.copilot
  ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  # zentch.depviz

  svelte.svelte-vscode
  ms-python.python
  bmewburn.vscode-intelephense-client
]
