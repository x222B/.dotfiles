# .dotfiles

This repository contains my linux configuration files (known as dotfiles).
Packages can be found in `./packages/pacman` and installed with `sudo pacman -S --needed - < ./packages/pacman`.

# Installation

> Note: Please read the installation script before running it. I recommend forking the repo.

Repository contains an automatic installation script `install.sh` inspired by [Adam Eivy's script](https://github.com/atomantic/dotfiles).
The script creates symlinks of all dotfiles, creates backups, installs packages, sets up Zsh and Oh-My-Zsh, creates necessary directories and changes some system settings.
If symlinked files already exist, they will be backed-up into `~/.dotfiles_backup/$date/`.


```bash
git clone --recursive https://github.com/x222b/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The script will guide you through the process. Some settings require sudo.
