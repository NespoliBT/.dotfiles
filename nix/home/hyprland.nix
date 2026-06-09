{ config, pkgs, ... }:
let
  hyprland-wrapper = pkgs.writeShellScriptBin "Hyprland" ''
    exec ${pkgs.hyprland}/bin/Hyprland --config "$HOME/.dotfiles/hypr/hyprland.conf" "$@"
  '';
in
{
  home.packages = with pkgs; [
    hyprland-wrapper
    pyprland
    hyprpicker
    hyprcursor
    catppuccin-cursors.mochaMauve
    hyprlock
    hypridle
    hyprpaper
    xdg-desktop-portal-hyprland
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "hyprland";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
