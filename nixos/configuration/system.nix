{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    #--
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    # "/dev/nvme0n1p1";
    useOSProber = false;
    theme = pkgs.fetchFromGitHub {
      owner = "gemakfy";
      repo = "MilkGrub";
      rev = "d455a655a0058ce0962d40f9c0160c934246745a";
      sha256 = "5Fv5IFm32HxyP77pY6VkuD+NPE3A0RS7OMTM0HtGK38=";
    };
  };

  networking.networkmanager.enable = true;

  networking.hostName = "nixos_enjoyer";
  time.timeZone = "Europe/Rome";

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
