{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    user = "nespoli";
    dataDir = "/home/nespoli";
    configDir = "/home/nespoli/.config/syncthing";
  };
}
