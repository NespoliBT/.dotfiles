{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    gtk4.theme = null;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark";
      package = pkgs.catppuccin-cursors;
      size = 24;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Tokyonight-Dark";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "Catppuccin-Mocha-Dark";
      cursor-size = 24;
    };
  };
}
