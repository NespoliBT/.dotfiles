{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [ (import "${home-manager}/nixos") ];

  home-manager.users.nespoli = {
    # The home.stateVersion option does not have a default and must be set
    home.stateVersion = "23.05";

   
  home.packages = [ pkgs.vscode ];

  };

}
