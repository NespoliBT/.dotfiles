# Users

{ pkgs, ... }:

{
  users.users.nespoli = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      (python311.withPackages
        (ps: with ps; [ requests pygame python-nmap pip ]))
      firefox
      tree
      git
      alacritty
      zsh
      eza
      bat
      eww
      rofi
      hyprpaper
      pfetch
      pywal
      pavucontrol
      socat
      jq
      telegram-desktop
      spotify
      playerctl
      libnotify
      vlc
      binutils
      bison
      neovim
      nodejs
      yarn
      brightnessctl
      gnumake
      xsel
      killall
      os-prober
      obsidian
      linuxKernel.packages.linux_6_1.cpupower
      gimp
      gum
      swww
      sassc
      inotify-tools
      steam
      xwayland
      gdb
      hyprlock
      hypridle
      bun
      sshuttle
      hyprcursor
      grim
      slurp
      nmap
      wl-clipboard
      adbfs-rootless
      android-tools
      glib
      neofetch
      alsa-utils
      zip
      unzip
      vim
      openocd
      pulseaudio
      nixfmt-classic
      sass
      ayugram-desktop
      onefetch
    ];
  };
  # Shame
  nixpkgs.config.allowUnfree = true;
}
