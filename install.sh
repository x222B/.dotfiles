#!/bin/bash
#This scripts configures dotfiles, installs packages and and configures additional system settings

################
#DOTFILES SETUP#
################

highlight() {
    echo "[1;34m::[0m [1m$*[0m"
}

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

highlight "Oh-My-Zsh Setup"
read -r -p "Install oh-my-zsh? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/zsh/custom}/plugins/zsh-syntax-highlighting
	highlight "Cloning zsh-completions"
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.config/zsh/custom}/plugins/zsh-completions
	highlight "Cloning zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/zsh/custom}/plugins/zsh-autosuggestions
	highlight "Copying theme"
	cp ./zsh/themes/lambda.zsh-theme ~/.config/zsh/custom/themes
	highlight "Copying Settings"
	cp ./zsh/*.zsh ~/.config/zsh
fi
