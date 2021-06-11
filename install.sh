#!/bin/bash
#This scripts configures dotfiles, installs packages and and configures additional system settings

################
#DOTFILES SETUP#
################

highlight() {
    echo "[1;34m::[0m [1m$*[0m"
}

# Install packages from ./packages/ directory
read -r -p "Install packages from ./packages/pacman? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
    sudo pacman -S --needed - < ./packages/pacman
fi

#Creates a backup of current dotfiles in ~/.dotfiles_backup/$now, removes existing symlinks and creates symlinks for new dotfiles
highlight "Dotfiles Setup"
read -r -p "symlink all dotfiles to ~? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
  highlight "Creating symlinks for dotfiles..."
  now=$(date +"%Y.%m.%d.%H.%M.%S")

  for file in .*; do
    #skips . and .. and .git
    if [[ $file == "." || $file == ".." || $file == ".git" ]]; then
      continue
    fi
    running "~/$file"
    # if the file exists:
    if [[ -e ~/$file ]]; then
        mkdir -p ~/.dotfiles_backup/$now
        mv ~/$file ~/.dotfiles_backup/$now/$file
        highlight "backup saved as ~/.dotfiles_backup/$now/$file"
    fi
    # symlink might still exist
    unlink ~/$file > /dev/null 2>&1
    # create the link
    ln -s ~/.dotfiles/$file ~/$file
    highlight -en '\tlinked';ok
  done
fi

# Create necessary directories if needed
if [[ ! -d ~/Pictures/Wallpapers ]]; then
    highlight "Creating ~/Pictures/Wallpapers"
    mkdir -p  ~/Pictures/Wallpapers
fi

if [[ ! -d ~/Pictures/screenshots ]]; then
    highlight "Creating ~/Pictures/screenshots"
    mkdir -p  ~/Pictures/screenshots
fi

# Add udev rules to allow the use of xbacklight without sudo
read -r -p "Add udev.rules to allow non-sudo xbacklight? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
    echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", GROUP="video", MODE="0664"' \
        | sudo tee /etc/udev/rules.d/backlight.rules > /dev/null
fi

# Set default ALSA device in /etc/asound.conf
read -r -p "Set default ALSA device? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
    read -r -p "Enter the device number: " device_num
    echo "defaults.pcm.card ${device_num}
defaults.ctl.card ${device_num}" \
    | sudo tee /etc/asound.conf > /dev/null
fi

read -r -p "Setup oh-my-zsh? [y|N]" response
if [[ $response =~ (y|yes|Y) ]]; then
    highlight "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
        echo "Could not install Oh My Zsh" >/dev/stderr
        exit 1
    }
    highlight "Cloning zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/zsh/custom}/plugins/zsh-syntax-highlighting
    highlight "Cloning zsh-completions"
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.config/zsh/custom}/plugins/zsh-completions
    highlight "Cloning zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/zsh/custom}/plugins/zsh-autosuggestions
    highlight "Copying theme"
    cp ./zsh/themes/lambda.zsh-theme ~/.config/zsh/custom/themes/
    highlight "Copying Settings"
    cp ./zsh/*.zsh ~/.config/zsh
    highlight "Copying .zshrc"
    cp ./.zshrc ~/.zshrc
fi
