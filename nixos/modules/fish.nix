{ config, pkgs, ... }:
let
  note = pkgs.writeShellScriptBin "note" (builtins.readFile ../scripts/note.sh);

in
{
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = [ note ];

  programs.fish.shellAbbrs = {
    ls = "eza --icons";
    cat = "bat -p";
    ip = "ip -c";
    ioquandosicasa = "sshuttle -r casaos@nespolibt.duckdns.org 0.0.0.0/0";
    twitch-live = "nix run nixpkgs#wayvnc 0.0.0.0";
    flake-template = "cp ~/.dotfiles/nixos/flake_templates/$argv[1].nix ./flake.nix";
  };

  programs.fish.shellAliases = {
    ls = "eza --icons";
    cat = "bat -p";
    ip = "ip -c";
  };

  programs.fish.interactiveShellInit = ''
    # Disable startup message
    set fish_greeting

    # Set environment variables
    set -gx VISUAL codium
    set -gx EDITOR nvim
    set -gx PATH $HOME/.local/share/bin /usr/local/bin $PATH

    # Start screen
    if test -d "./.git/"
      onefetch
    else
      pfetch
    end
  '';
}
