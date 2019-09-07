#!/usr/bin/env bash
#This scripts configures dotfiles, installs packages and and configures additional system settings

#########################
#Include colorized echos#
#########################
source .lib/echos.sh

###################################
#/etc/hosts -- spyware/ad blocking#
###################################
read -r -p "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org?[y|N] " response
if [[ $response =~ (yes|y|Y) ]];then
	action "Creating a backup of /etc/hosts"
	sudo cp /etc/hosts /etc/hosts.backup
	ok
	action "Replacing /etc/hosts"
	sudo cp ./configs/hosts /etc/hosts
	ok
	green "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
else
	ok "skipped";
fi


################
#DOTFILES SETUP#
################

#Creates a backup of current dotfiles in ~/.dotfiles_backup/$now, removes existing symlinks and creates symlinks for new dotfiles
green "Dotfiles Setup"
read -r -p "symlink all dotfiles to ~/? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
  green "Creating symlinks for dotfiles..."
  now=$(date +"%Y.%m.%d.%H.%M.%S")

  for file in .*; do
    if [[ $file == "." || $file == ".." ]]; then
      continue
    fi
    running "~/$file"
    # if the file exists:
    if [[ -e ~/$file ]]; then
        mkdir -p ~/.dotfiles_backup/$now
        mv ~/$file ~/.dotfiles_backup/$now/$file
        echo "backup saved as ~/.dotfiles_backup/$now/$file"
    fi
    # symlink might still exist
    unlink ~/$file > /dev/null 2>&1
    # create the link
    ln -s ~/.dotfiles/$file ~/$file
    echo -en '\tlinked';ok
  done
fi

#################
#PACKAGE INSTALL#
#################

#Installs packages found in .pkglist
green "Installing packages"

#Installs packages from official repositories
action "Installing all the packages specified in .pkglist/pacman"
pacman -Syy $(cat .pkglist/pacman)

#Installs yay
action "Installing yay"
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar xfz yay.tar.gz
cd yay
makepkg -si

#Installs packages from Arch User respositorArch User respository
action "Installing all the packages specified in .pkglist/aur"
yay -S $(.pkglist/aur)

#############
#MISC CONFIG#
#############

#Change shell to zsh
if [[ "$SHELL" != "/bin/zsh" ]]; then
  action "Setting zsh as your shell (password required)"
  chsh -s /bin/zsh
  ok
fi

#Change Keyboard layout
read -r -p "Enter Xorg keyboard layout:" response
localectl --no-convert set-x11-keymap $response "" "" ""
read -r -p "Enter TTY keymap" response
echo 'KEYMAP='$response > /etc/vconsole.conf
ok

#Disable PC speaker
action "Disabling PC speaker"
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

#The End
green "All done. Note that some of the changes require a logout/reboot to take effect."

