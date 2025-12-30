{ pkgs, lib, ... }:

let
  userSettings = import ./userSettings.nix { lib = lib; };
  vscodeExtensions = import ./extensions.nix { pkgs = pkgs; };
  keybindings = ./settings/keybindings.json;
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhs;

    profiles.default = {
      userSettings = builtins.fromJSON userSettings;
      extensions = vscodeExtensions;
      keybindings = keybindings;
    };
  };
}
