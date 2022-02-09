# .dotfiles setup script

# ! TODO ! #
# install preferred backage manager (yay, brew)
# install vim and config
# install zsh, oh-my-zsh and config
# optional: telegram and spotify
# install git and config
# install jetbrains mono
# install vscode
# install nvm, npm, yarn
# install docker
# install python and pip
# install pfetch
# symlink .zshrc
# symlink .gitconfig
# symlink .vimrc

nodeVersion = "14"

yayPackages = [
    'zsh',
    'vim',
    'git',
    'nerd-fonts-jetbrains-mono',
    'visual-studio-code-bin',
    'docker',
    'python',
    'pfetch'
]

$columns = `tput cols`.to_i
$divider = '=' * $columns
$os = `uname`

class String
    # colorization
    def colorize(color_code)
      "\e[#{color_code}m#{self}\e[0m"
    end
  
    def red
      colorize(31)
    end
  
    def green
      colorize(32)
    end
  
    def yellow
      colorize(33)
    end
  
    def blue
      colorize(34)
    end
  
    def pink
      colorize(35)
    end
  
    def light_blue
      colorize(36)
    end
  end

def putCenter(text)
  puts " " * (($columns - text.length) / 2) + text
end

# Welcome screen
puts $divider.yellow
puts
putCenter "NespoliBT's .dotfiles".light_blue
puts
puts $divider.yellow

case
when $os.include?('Darwin')
    puts "Detected OS: MacOS".green
    puts "Installing Homebrew".blue
    system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')

when $os.include?('Linux')
    puts "Detected OS: Linux".green
    puts "This is arch, right?! [Y/n]".yellow
    
    answer = gets.chomp

    if answer.downcase != "y" and answer != ""
        puts "This is not arch, exiting...".red
        exit
    end

    system('pacman -S sudo --noconfirm')

    # Enable wheel group as super users
    data = File.read("/etc/sudoers") 
    filtered_data = data.gsub("# %wheel", "%wheel")
    File.open("/etc/sudoers", "w") do |f|
        f.write(filtered_data)
    end

    # Enable pacman color
    data = File.read("/etc/pacman.conf") 
    filtered_data = data.gsub("#Color", "Color")
    File.open("/etc/pacman.conf", "w") do |f|
        f.write(filtered_data)
    end

    puts $divider.pink
    puts
    putCenter("Creating new user".blue)
    puts
    puts $divider.pink

    puts("Enter username: [Enter to skip]")
    username = gets.chomp

    if(username.length > 0)
        system("useradd -m -G wheel #{username}")

        puts("Enter #{username}'s password:")
        system("passwd #{username}")
    end

    puts "Installing yay"

    # ? Doing stuff as user
    system("
        runuser -l #{username} -c '

            # ? Install yay
            sudo -S pacman -Syu --noconfirm
            sudo -S pacman -S --needed git base-devel --noconfirm
            git clone https://aur.archlinux.org/yay-bin.git
            cd yay-bin
            makepkg -si
            cd ..
            rm -rf yay-bin

            # ? Install packages
            yay -S --noconfirm #{yayPackages.join(' ')}

            # ? Install nvm (node version manager)
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
            export NVM_DIR=\"$HOME/.nvm\"
            [ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"  # This loads nvm
            [ -s \"$NVM_DIR/bash_completion\" ] && \. \"$NVM_DIR/bash_completion\"  # This loads nvm bash_completion
            nvm install #{nodeVersion}

            # ? Download this repository
            git clone https://github.com/NespoliBT/.dotfiles.git

            # ! Tenere alla fine
            # ? Install oh-my-zsh
            KEEP_ZSHRC=yes
            sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended \"\" --keep-zshrc

            # ? configs
            rm ~/.zshrc
            rm ~/.zshrc.pre-oh-my-zsh
            ln -s ~/.dotfiles/.zshrc ~/.zshrc
            ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
            ln -s ~/.dotfiles/.vimrc ~/.vimrc

            cd

        '
    ")
    system("chsh -s /bin/zsh #{username}")
end
