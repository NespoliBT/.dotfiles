{ config, pkgs, ... }: {

  home.file.".zshrc".source = ../../../.zshrc;

  home.packages = with pkgs; [ ];
}
