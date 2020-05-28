#!/bin/bash
#This scripts configures dotfiles, installs packages and and configures additional system settings

#include colorized echos
source .lib/echos.sh

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

