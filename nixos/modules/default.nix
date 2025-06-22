{ config, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./pipewire.nix
    ./hyprland.nix
    ./zsh.nix
    ./bluetooth.nix
    ./flatkpak.nix
    # --
  ];

  services.upower.enable = true;
}
