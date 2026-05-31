{
  config,
  pkgs,
  caelestia-shell,
  ...
}:
{
  imports = [
    ./dotfiles/hyprland.nix
    # ./dotfiles/zsh.nix
    ./dotfiles/gtk.nix
    ./dotfiles/caelestia.nix
    ./dotfiles/vim.nix
    ./dotfiles/git.nix
    ./dotfiles/alacritty.nix
    ./dotfiles/zen.nix
    ./dotfiles/code/vscodium.nix
    caelestia-shell.homeManagerModules.default
    # --
  ];

  home.username = "nespoli";
  home.homeDirectory = "/home/nespoli";

  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;

  home.packages = [
    pkgs.brightnessctl
    pkgs.alacritty
    pkgs.firefox
    pkgs.rofi
    pkgs.nixfmt
    pkgs.pavucontrol
    pkgs.eza
    pkgs.bat
    pkgs.ayugram-desktop
    pkgs.pywal
    pkgs.pfetch
    pkgs.awww
    pkgs.wl-clipboard
    pkgs.slurp
    pkgs.steam
    pkgs.gum
    pkgs.grim
    pkgs.love
    pkgs.tmux
    pkgs.jdk
    pkgs.obsidian
    pkgs.sunsetr
    pkgs.quickshell
    pkgs.github-copilot-cli
    pkgs.remmina
    pkgs.freerdp
    pkgs.nix-search
    pkgs.pywalfox-native
    caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
  ];
}
