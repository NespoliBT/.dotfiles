{ config, pkgs, ... }:
let
  note = pkgs.writeShellScriptBin "note" (builtins.readFile ../scripts/note.sh);

in
{
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = [ note ];
}
