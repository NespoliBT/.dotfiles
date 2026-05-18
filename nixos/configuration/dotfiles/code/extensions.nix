{ pkgs }:

let
  caelestiaExt = pkgs.stdenv.mkDerivation {
    name = "caelestia-vscode-integration";
    src = ../../dotfiles/code/extensions/caelestia-vscode-integration;
    version = "1.2.0";
    vscodeExtPublisher = "soramanew";
    vscodeExtName = "caelestia-vscode-integration";
    vscodeExtUniqueId = "soramanew.caelestia-vscode-integration";
    installPhase = ''
      mkdir -p $out/share/vscode/extensions/$vscodeExtUniqueId
      cp -r extension/* $out/share/vscode/extensions/$vscodeExtUniqueId/
      cp "[Content_Types].xml" extension.vsixmanifest $out/share/vscode/extensions/$vscodeExtUniqueId/ 2>/dev/null || true
    '';
  };

in
(with pkgs.vscode-extensions; [
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
  github.copilot
  meganrogge.template-string-converter
  ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  # zentch.depviz

  svelte.svelte-vscode
  ms-python.python
  bmewburn.vscode-intelephense-client
  #theqtcompany.qt-qml
  
])
++ [
  caelestiaExt
]
