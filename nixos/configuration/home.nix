{ config, pkgs, ... }: {
  imports = [
    ./dotfiles/hyprland.nix
    ./dotfiles/zsh.nix
    ./dotfiles/gtk.nix
    ./dotfiles/vim.nix
    # --
  ];

  home.username = "nespoli";
  home.homeDirectory = "/home/nespoli";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
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
