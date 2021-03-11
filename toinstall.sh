# Update everything
pacman -Syu

# Add git and base-devel
pacman -S git base-devel 

# Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Polybar
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