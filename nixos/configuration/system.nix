{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    #--
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    # "/dev/nvme0n1p1";
    useOSProber = false;
  };

  networking.networkmanager.enable = true;

  networking.hostName = "nixos_enjoyer";
  time.timeZone = "UTC";

  users.mutableUsers = false;

  users.users.nespoli = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "test";
  };

  # Shame
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
