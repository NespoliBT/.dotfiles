# Programs
{ config, pkgs, ... }:

{
    programs.mtr.enable = true;
    programs.hyprland.enable = true;

    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };
    
    programs.zsh = {
        enable = true;
        ohMyZsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "robbyrussell";
        };
    };
}
