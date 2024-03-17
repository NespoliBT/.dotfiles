{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.nespoli = {
    home.packages = [ pkgs.atool pkgs.httpie ];
    home.stateVersion = "23.05";
  };
}