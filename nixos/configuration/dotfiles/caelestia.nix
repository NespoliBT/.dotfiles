{ config, pkgs, ... }:
{
  programs.caelestia = {
    enable = true;
    cli.enable = true;

    settings = {
      appearance = {
        transparency = {
          enabled = false;
        };
      };

      background = {
        desktopClock = {
          background = {
            enabled = false;
          };
          enabled = true;
          invertColors = false;
        };
        visualiser = {
          enabled = true;
        };
      };

      bar = {
        activeWindow = {
          compact = false;
          inverted = false;
        };
        clock = {
          background = false;
          showDate = false;
        };
        excludedScreens = [ ];
        popouts = {
          statusIcons = true;
        };
        scrollActions = {
          volume = true;
          workspaces = true;
        };
        status = {
          showKbLayout = true;
          showLockStatus = true;
          showNetwork = true;
          showWifi = true;
        };
        tray = {
          background = false;
        };
        workspaces = {
          occupiedBg = false;
        };
      };

      launcher = {
        favouriteApps = [
          "firefox"
          "codium"
          "com.ayugram.desktop"
        ];
        showOnHover = true;
      };

      utilities = {
        vpn = {
          provider = [
            {
              displayName = "Tailscale";
              enabled = true;
              interface = "tailscale0";
              name = "tailscale";
            }
          ];
        };
      };
    };
  };
}
