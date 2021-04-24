#Style
red='\e[31m'
green='\e[32m'
normal=$(tput sgr0)

printProgress() {
    if [[ "$2" == "starting" ]]; then
	    printf "${red}\n$1 $2\n${normal}"
    else
	    printf "${green}$1 $2\n${normal}"
    fi
}


# Update everything
printProgress update: starting
pacman -Syu
printProgress update: done

# Add git and base-devel
printProgress adding git and base-devel: starting
pacman -S git base-devel
printProgress adding git and base-devel: done 

# Yay
printProgress cloning yay from git: starting
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
printProgress cloning yay from git: done

# Polybar
printProgress installing Polybar, VScode, Pywal and other stuffs... : starting
yay polybar

# VSCode
yay code

# Pywal
yay pywal

# Oh my zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Pfetch
yay pfetch

# Fonts
yay ttf-fantasque-sans-mono
yay otf-fantasque-sans-mono
yay nerd-fonts-iosevka
yay
printProgress installing Polybar, VScode, Pywal and other stuffs... : starting
