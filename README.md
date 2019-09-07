This repository serves as a backup of my linux configuration files (also known as *dotfiles*).  
## Installation
`./install.sh` creates a backup of old dotfiles, creates symlinks, installs packages from `~/.pkglist` and changes some linux configurations.  
In case of errors you can use `./restore.sh $RESTOREDATE` where `$RESTOREDATE` is the date folder you want to restore.  
`restore.sh` deletes symlinks and restores old dotfiles. It does not uninstall packages or changes system settings. You need to do that manually.

## Packages
The package lists can be found in `~/.pkglist/`.  
To install all official packages, you can use for example `pacman -S $(cat pacman)` or `cat pacman | pacman -S -`.  
To create a dump of currently installed packages use `paclist.sh`
