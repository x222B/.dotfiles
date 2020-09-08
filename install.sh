#!/bin/bash
#This scripts configures dotfiles, installs packages and and configures additional system settings

################
#DOTFILES SETUP#
################


#Creates a backup of current dotfiles in ~/.dotfiles_backup/$now, removes existing symlinks and creates symlinks for new dotfiles
echo "Dotfiles Setup"
read -r -p "symlink all dotfiles to ~? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
  echo "Creating symlinks for dotfiles..."
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
        echo "backup saved as ~/.dotfiles_backup/$now/$file"
    fi
    # symlink might still exist
    unlink ~/$file > /dev/null 2>&1
    # create the link
    ln -s ~/.dotfiles/$file ~/$file
    echo -en '\tlinked';ok
  done
fi

echo "Oh-My-Zsh Setup"
read -r -p "Install oh-my-zsh? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
	echo "Cloning oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "Cloning zsh-syntax-highlighting"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	echo "Cloning zsh-completions"
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
	echo "Cloning zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
