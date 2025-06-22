{ config, pkgs, ... }: {
  imports = [
    ./dotfiles/hyprland.nix
    ./dotfiles/zsh.nix
    ./dotfiles/gtk.nix
    # --
  ];

  home.username = "nespoli";
  home.homeDirectory = "/home/nespoli";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    vim
    git
    brightnessctl
    kitty
    firefox
    vscode
    rofi
    nixfmt-classic
    pavucontrol
    eza
    bat
    ayugram-desktop
    pywal
    pfetch
    swww
    wl-clipboard
    slurp
    steam
  ];
}
