{ lib, pkgs, zen-browser, ... }:
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

      update_zen() {
        local primary base mantle mode
        primary="#$(jq -r '.colours.primary' "$scheme_path")"
        base="#$(jq -r '.colours.base' "$scheme_path")"
        mantle="#$(jq -r '.colours.mantle' "$scheme_path")"
        mode="$(jq -r '.mode' "$scheme_path")"

        for profile_dir in "$HOME"/.zen/*/ "$HOME"/.config/zen/*/; do
          if [ -f "''${profile_dir}prefs.js" ]; then
            mkdir -p "''${profile_dir}chrome"
            rm -f "''${profile_dir}chrome/userChrome.css"
            {
              printf ':root {\n'
              printf '  --zen-primary-color: %s !important;\n' "$primary"
              if [ "$mode" = "dark" ]; then
                printf '  --zen-branding-dark: %s !important;\n' "$base"
              else
                printf '  --zen-branding-paper: %s !important;\n' "$base"
              fi
              printf '  --zen-themed-toolbar-bg-transparent: %s !important;\n' "$mantle"
              printf '  --toolbarbutton-icon-fill: %s !important;\n' "$primary"
              printf '}\n'
              printf '#zen-browser-background, #zen-toolbar-background {\n'
              printf '  --zen-main-browser-background: %s !important;\n' "$mantle"
              printf '  --zen-main-browser-background-toolbar: %s !important;\n' "$mantle"
              printf '}\n'
              cat ${./zen-userChrome.css}
            } > "''${profile_dir}chrome/userChrome.css"
            {
              printf 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);\n'
              printf 'user_pref("zen.theme.accent-color", "%s");\n' "$primary"
            } > "''${profile_dir}user.js"
            log "updated zen scheme: primary=$primary mode=$mode in ''${profile_dir}"
          fi
        done
      }

      state_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/caelestia"
      scheme_path="$state_dir/scheme.json"

      log "started (HOME=$HOME, scheme=$scheme_path)"
      message "$(jq -c . "$scheme_path")"
      update_zen
      log "watching $state_dir"

      inotifywait -q -e 'close_write,moved_to,create' -m "$state_dir" | while read -r dir _ file; do
        if [ "''${dir}''${file}" = "$scheme_path" ]; then
          message "$(jq -c . "$scheme_path")"
          update_zen
        fi
      done
    '';
  };
in
{
  home.packages = [ zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta ];

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "zen.desktop" ];
    "x-scheme-handler/http" = [ "zen.desktop" ];
    "x-scheme-handler/https" = [ "zen.desktop" ];
    "x-scheme-handler/about" = [ "zen.desktop" ];
  };

  home.activation.zenChrome = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    scheme="''${XDG_STATE_HOME:-$HOME/.local/state}/caelestia/scheme.json"

    for profile_dir in "$HOME"/.zen/*/ "$HOME"/.config/zen/*/; do
      if [ -f "$profile_dir/prefs.js" ]; then
        mkdir -p "$profile_dir/chrome"
        rm -f "$profile_dir/chrome/userChrome.css"

        if [ -f "$scheme" ]; then
          primary="#$(${pkgs.jq}/bin/jq -r '.colours.primary' "$scheme")"
          base="#$(${pkgs.jq}/bin/jq -r '.colours.base' "$scheme")"
          mantle="#$(${pkgs.jq}/bin/jq -r '.colours.mantle' "$scheme")"
          mode="$(${pkgs.jq}/bin/jq -r '.mode' "$scheme")"
          {
            printf ':root {\n'
            printf '  --zen-primary-color: %s !important;\n' "$primary"
            if [ "$mode" = "dark" ]; then
              printf '  --zen-branding-dark: %s !important;\n' "$base"
            else
              printf '  --zen-branding-paper: %s !important;\n' "$base"
            fi
            printf '  --zen-themed-toolbar-bg-transparent: %s !important;\n' "$mantle"
            printf '  --toolbarbutton-icon-fill: %s !important;\n' "$primary"
            printf '}\n'
            printf '#zen-browser-background, #zen-toolbar-background {\n'
            printf '  --zen-main-browser-background: %s !important;\n' "$mantle"
            printf '  --zen-main-browser-background-toolbar: %s !important;\n' "$mantle"
            printf '}\n'
            cat ${./zen-userChrome.css}
          } > "$profile_dir/chrome/userChrome.css"
          {
            printf 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);\n'
            printf 'user_pref("zen.theme.accent-color", "%s");\n' "$primary"
          } > "$profile_dir/user.js"
        else
          ln -sf ${./zen-userChrome.css} "$profile_dir/chrome/userChrome.css"
          printf 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);\n' > "$profile_dir/user.js"
        fi
      fi
    done
  '';

  home.file.".mozilla/native-messaging-hosts/caelestiafox.json".text = builtins.toJSON {
    name = "caelestiafox";
    description = "Native app for CaelestiaFox extension.";
    path = "${caelestiafox}/bin/caelestiafox";
    type = "stdio";
    allowed_extensions = [ "caelestiafox@caelestia.org" ];
  };
}
