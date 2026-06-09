{ config, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    #--
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.initrd.luks.devices."luks-f41d2b4a-3c3c-4be2-95fd-8156cab9c76b".device =
    "/dev/disk/by-uuid/f41d2b4a-3c3c-4be2-95fd-8156cab9c76b";

  boot.loader = {
    systemd-boot.enable = false;

    grub = {
      enable = true;
      device = "nodev";
      useOSProber = false;
      efiSupport = true;

      theme = pkgs.fetchFromGitHub {
        owner = "gemakfy";
        repo = "MilkGrub";
        rev = "d455a655a0058ce0962d40f9c0160c934246745a";
        sha256 = "5Fv5IFm32HxyP77pY6VkuD+NPE3A0RS7OMTM0HtGK38=";
      };
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking.networkmanager.enable = true;
  networking.hostName = "nixos_enjoyer";
  time.timeZone = "Europe/Rome";

  users.mutableUsers = false;

  users.users.nespoli = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$bltMt7lufxFBmg47$jAw3d1eBnsM4JDmvQUaLZj/pkG1tFyCSrWXqc2rJn4bbdXqZyKWGi5jph2uwa7Lwhs3D3UCp07zYueNXLO1rG0";
  };

  # Shame
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
