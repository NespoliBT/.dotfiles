{ config, pkgs, ... }:
{
  imports = [
    ./dotfiles/hyprland.nix
    # ./dotfiles/zsh.nix
    ./dotfiles/gtk.nix
    ./dotfiles/vim.nix
    ./dotfiles/git.nix
    ./dotfiles/code/vscodium.nix
    # --
  ];

  home.username = "nespoli";
  home.homeDirectory = "/home/nespoli";

  home.stateVersion = "26.05";

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
  ];
}
