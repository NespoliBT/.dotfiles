# Users

{pkgs, ...}:

{
    users.users.nespoli = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ];
        shell = pkgs.zsh;

        packages = with pkgs; [
            (python310.withPackages(ps: with ps; [
                requests
                pygame
                numpy
            ]))
            openjdk19
            firefox
            tree
            git
            kitty
            vscode
            zsh
            eza
            bat
            eww
            rofi
            hyprpaper
            pfetch
            pywal
            python3
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
	    distrobox
            obsidian
            linuxKernel.packages.linux_6_1.cpupower
            notion-app-enhanced
            gimp
            minecraft
            gum
            swww
            sassc
            inotify-tools
        ];
    };

    # System packages
    environment.systemPackages = with pkgs; [
        vim
        wget
    ];

    # Shame
    nixpkgs.config.allowUnfree = true;
}
