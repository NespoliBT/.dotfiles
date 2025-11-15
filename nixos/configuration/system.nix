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
    theme = pkgs.fetchFromGitHub {
      owner = "gemakfy";
      repo = "MilkGrub";
      rev = "d455a655a0058ce0962d40f9c0160c934246745a";
      sha256 = "5Fv5IFm32HxyP77pY6VkuD+NPE3A0RS7OMTM0HtGK38=";
    };
    extraEntries = ''
      menuentry 'Arch Linux' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-55d42f6d-51b1-405d-b5f4-7953f2e56487' {
      	insmod part_gpt
      	insmod ext2
      	search --no-floppy --fs-uuid --set=root 55d42f6d-51b1-405d-b5f4-7953f2e56487
      	linux /boot/vmlinuz-linux root=/dev/nvme0n1p3
      	initrd /boot/initramfs-linux.img
      }
    '';
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
