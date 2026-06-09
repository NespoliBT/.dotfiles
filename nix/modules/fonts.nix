{ config, pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      proggyfonts
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];
    enableDefaultPackages = true;
    fontconfig.defaultFonts = {
      monospace = [ "Fira Code" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };
}
