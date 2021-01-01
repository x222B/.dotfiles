"""""""""""
"  VIMRC  "
"""""""""""

" Setup directories and vim-plug {{{

if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')
    silent !mkdir -p ~/.config/nvim/autoload >/dev/null 2>&1
    silent !mkdir -p ~/.config/nvim/plugged >/dev/null 2>&1
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                \ >/dev/null 2>&1
    autocmd VimEnter * PlugInstall
endif

" }}}

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

let g:plug_url_format = 'https://github.com/%s.git'

Plug 'lifepillar/vim-gruvbox8'

call plug#end()
" }}}

" Theme and colors
set termguicolors
set background=dark
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
colorscheme gruvbox8
