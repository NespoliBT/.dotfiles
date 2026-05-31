{ config, pkgs, zen-browser, ... }:
let
  caelestiafox = pkgs.writeTextFile {
    name = "caelestiafox";
    executable = true;
    destination = "/bin/caelestiafox";
    text = ''
      #!/usr/bin/env ${pkgs.fish}/bin/fish

      function message -a msg
        set -l x (printf '%08X' (string length -- $msg))
        printf '%b' "\x$(string sub -s 7 -l 2 $x)\x$(string sub -s 5 -l 2 $x)\x$(string sub -s 3 -l 2 $x)\x$(string sub -s 1 -l 2 $x)"
        printf '%s' $msg
      end

      set -q XDG_STATE_HOME && set -l state $XDG_STATE_HOME || set -l state $HOME/.local/state
      set -l state_dir $state/caelestia
      set -l scheme_path $state_dir/scheme.json

      message (${pkgs.jq}/bin/jq -c . $scheme_path)

      ${pkgs.inotify-tools}/bin/inotifywait -q -e 'close_write,moved_to,create' -m $state_dir | while read dir events file
        test "$dir$file" = $scheme_path && message (${pkgs.jq}/bin/jq -c . $scheme_path)
      end
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

  home.file.".zen/c2mol9ml.Default Profile/chrome/userChrome.css".source = ./zen-userChrome.css;
  home.file.".zen/c2mol9ml.Default Profile/user.js".text = ''
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
  '';

  home.file.".mozilla/native-messaging-hosts/caelestiafox.json".text = builtins.toJSON {
    name = "caelestiafox";
    description = "Native app for CaelestiaFox extension.";
    path = "${caelestiafox}/bin/caelestiafox";
    type = "stdio";
    allowed_extensions = [ "caelestiafox@caelestia.org" ];
  };
}
