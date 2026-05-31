{ config, pkgs, zen-browser, ... }:
let
  caelestiafox = pkgs.writeShellApplication {
    name = "caelestiafox";
    runtimeInputs = [ pkgs.fish pkgs.jq pkgs.inotify-tools ];
    text = ''
      exec fish ${./caelestiafox.fish}
    '';
  };
in
{
  imports = [
    zen-browser.homeModules.beta
    # or zen-browser.homeModules.twilight
    # or zen-browser.homeModules.twilight-official
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      isDefault = true;

      userChrome = builtins.readFile ./zen-userChrome.css;

      extraConfig = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
      '';
    };
  };

  home.file.".mozilla/native-messaging-hosts/caelestiafox.json".text = builtins.toJSON {
    name = "caelestiafox";
    description = "Native app for CaelestiaFox extension.";
    path = "${caelestiafox}/bin/caelestiafox";
    type = "stdio";
    allowed_extensions = [ "caelestiafox@caelestia.org" ];
  };
}
