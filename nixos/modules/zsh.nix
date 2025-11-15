{ config, pkgs, ... }:
let
  note = pkgs.writeShellScriptBin "note" (builtins.readFile ../scripts/note.sh);

in {
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = [ note ];
}
