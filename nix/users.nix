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
            ]))
            firefox
            tree
            git
            kitty
            vscode
            zsh
            eza
            bat
            eww-wayland
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
            mako
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
