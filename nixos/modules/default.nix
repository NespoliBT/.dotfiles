{ config, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./pipewire.nix
    ./hyprland.nix
    ./zsh.nix
    # --
  ];

  services.upower.enable = true;
}
