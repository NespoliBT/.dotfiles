{ config, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./pipewire.nix
    ./hyprland.nix
    ./zsh.nix
    ./flatpak.nix
    ./bluetooth.nix
    ./share.nix
    # --
  ];

  services.upower.enable = true;
  services.input-remapper.enable = true;
}
