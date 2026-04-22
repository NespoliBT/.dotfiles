{ config, pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./pipewire.nix
    ./hyprland.nix
    # ./zsh.nix
    ./fish.nix
    ./flatpak.nix
    ./bluetooth.nix
    ./share.nix
    ./syncthing.nix
    # --
  ];

  services.upower.enable = true;
  services.input-remapper.enable = true;
}
