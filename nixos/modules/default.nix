{ config, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./pipewire.nix
    ./hyprland.nix
    ./zsh.nix
    ./flatpak.nix
    ./bluetooth.nix
    # --
  ];

  services.upower.enable = true;
}
