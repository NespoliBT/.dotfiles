# NixOS Config File

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./localization.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./home-manager.nix
  ];

  home-manager.useUserPackages = true;
  home-manager.users.nespoli = {
    home.packages = with pkgs;
      [
        # packages
      ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot loader stuff 

  #boot.loader = {
  #  systemd-boot.enable = true;
  #  efi.canTouchEfiVariables = true;
  #}

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = false;
    };
    efi.canTouchEfiVariables = true;
  };

  # Security
  security.polkit.enable = true;
  security.rtkit.enable = true;

  fonts = {
    fontconfig = {
      defaultFonts = {
        serif = [ "Vazirmatn" "Ubuntu" ];
        sansSerif = [ "Vazirmatn" "Ubuntu" ];
        monospace = [ "Ubuntu" ];
      };
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    proggyfonts
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.droid-sans-mono
  ];

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

  services.xserver = {
    enable = true;
    #  displayManager.gdm.enable = true;
    #  desktopManager.gnome.enable = true;
  };

  services.udev.packages = [ pkgs.openocd pkgs.platformio-core ];

  # Docker
  virtualisation.podman.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  users.extraGroups.docker.members = [ "nespoli" ];
  programs.hyprland.enable = true;

  # Required for Wayland screen sharing
  xdg.portal = {
    enable = true;
    wlr.enable = true; # For wlroots-based compositors (Hyprland)
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland # Hyprland-specific portal
    ];
  };

  system.stateVersion = "23.05";
}

