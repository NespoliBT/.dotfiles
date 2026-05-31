{ config, pkgs, zen-browser, ... }:
let
  caelestiafox = pkgs.writeShellApplication {
    name = "caelestiafox";
    runtimeInputs = [ pkgs.jq pkgs.inotify-tools ];
    text = ''
      log() { echo "$(date -Iseconds) $*" >> "$HOME/.local/state/caelestia/caelestiafox.log"; }

      message() {
        local msg="$1"
        local len=''${#msg}
        printf '%b' "\\x$(printf '%02x' $((len & 0xff)))"
        printf '%b' "\\x$(printf '%02x' $(( (len >> 8) & 0xff)) )"
        printf '%b' "\\x$(printf '%02x' $(( (len >> 16) & 0xff)) )"
        printf '%b' "\\x$(printf '%02x' $(( (len >> 24) & 0xff)) )"
        printf '%s' "$msg"
        log "sent ''${len}B message"
      }

      state_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/caelestia"
      scheme_path="$state_dir/scheme.json"

      log "started (HOME=$HOME, scheme=$scheme_path)"
      message "$(jq -c . "$scheme_path")"
      log "watching $state_dir"

      inotifywait -q -e 'close_write,moved_to,create' -m "$state_dir" | while read -r dir _ file; do
        if [ "''${dir}''${file}" = "$scheme_path" ]; then
          message "$(jq -c . "$scheme_path")"
        fi
      done
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
