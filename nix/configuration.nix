# NixOS Config File

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./localization.nix
      ./networking.nix
      ./programs.nix
      ./services.nix
      ./users.nix
      ./homemanager.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Boot loader stuff 

  #boot.loader = {
  #  systemd-boot.enable = true;
  #  efi.canTouchEfiVariables = true;
  #}

   boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiSupport = true;
      # efiInstallAsRemovable = true;
      device = "nodev";
      # useOSProber = true;
      extraEntries = ''
           menuentry "Arch" {
		set root="UUID=66f071fa-e2b4-4e0d-8223-2bd91726306b"
		chainloader /vmlinuz-linux
	   }
          
      '';
    };
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
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Docker
  virtualisation.podman.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  xdg.portal.wlr.enable = true;

  system.stateVersion = "23.05";
}

