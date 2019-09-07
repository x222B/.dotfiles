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

read -r -p "Do you want to install packages from .pkglist/pacman? [y/N]" response
if [[$response =~ (y|yes|Y) ]]; then
	read -r -p "Do you want to edit the package list? (Installs all packages by default) [y/N]" response
	if [[$response =~ (y|yes|Y) ]]; then
		nano ./.pkglist/pacman
	fi
	action "Installing packages from .pkglist/pacman"
	while IFS= read -r line
	do
		echo -n "Installing $line"
		yes | pacman -S $line >/dev/null 2>&1
		ok
	done < ".pkglist/pacman"
fi
	
read -r -p "Do you want to install packages from .pkglist/aur? (Requires yay) [y/N]" response
if [[ $response =~ (y|yes|Y) ]]; then
	action "Resolving dependencies"
	if (pacman -Q go >/dev/null) ; then pacman -S --noconfirm go fi
	if (pacman -Q git >/dev/null) ; then pacman -S --noconfirm git fi
	
	action "Installing yay"
	curl -O -s https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
	tar xfz yay.tar.gz
	pushd yay >/dev/null 2>&1
	makepkg -si
	popd >/dev/null 2>&1
	rm -rf yay*	
	ok
	read -r -p "Do you want to edit the package list? (Installs all the packages by default) [y/N]" response
	if  [[ $response =~ (y|yes|Y) ]]; then
		nano .pkglist/aur
	fi
	while IFS= read -r line
	do
		echo -n "Installing $line"
		yes | yay -S $line >/dev/null 2>&1
		ok
	done < ".pkglist/aur"
fi

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

