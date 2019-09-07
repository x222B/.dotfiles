This repository is a backup of my linux configuration files (also known as *dotfiles*).  
## Installation
To install all dotfiles use `setup.sh`. It creates a backup of old dotfiles and creates symlinks.  
In case of error you can use `restore.sh` which deletes the symlinks and restores old files.  

## Packages
The package lists can be found in `~/.pkglist/`.  
To install all official packages, you can use for example `pacman -S $(cat pacman)` or `cat pacman | pacman -S -`.  
To create a dump of currently installed packages use `paclist.sh`
