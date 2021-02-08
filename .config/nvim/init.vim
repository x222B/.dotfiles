"""""""""""
"  VIMRC  "
"""""""""""

" Setup directories and vim-plug: {{{

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

Plug 'morhetz/gruvbox'

call plug#end()
" }}}

" Theme {{{

" Theme and colors
set termguicolors
set background=dark
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
colorscheme gruvbox

" }}}

" Settings {{{
set number
set hidden
set cursorline
set list
set nowrap
set mouse=ar
set laststatus=2
set showtabline=2
set tabpagemax=50
set previewheight=5
set noshowmode
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoread
set nostartofline

set tabstop=4
set shiftwidth=4
set autoindent
set smarttab
set textwidth=80
set scrolloff=3
set sidescroll=1
set sidescrolloff=0

set wildmode=longest:full,full
set wildignorecase
set wildignore+=.ignore,.gitignore
set wildignore+=*/.git/,*/.hg/,*/.svn/
set wildignore+=*/.ccls-cache/,*/.clangd/
set wildignore+=*.o,*.so,*.class,*.exe,*.dll,*.com
set wildignore+=.tmux,.nvimrc,.vimrc,.exrc
set wildignore+=tags,.tags,*/.backup/,*/.vim-backup/,*/.swap/,*/.vim-swap/,*/.undo/,*/.vim-undo/,*/._pkg/
set wildignore+=*.cache,*.log,*~,*#,*.bak,*.BAK,*.old,*.OLD,*.off,*.OFF,*.dist,*.DIST,*.orig,*.ORIG,*.rej,*.REJ,.DS_Store*
set wildignore+=*.swp,*.swo,*.swn,*.swm,*.tmp
set wildignore+=*.pid,*.state
set wildignore+=*.dump,*.stackdump,*.zcompdump,*.zwc,*.pcap,*.cap,*.dmp
set wildignore+=*.err,*.error,*.stderr
set wildignore+=*history,*_history,*_hist
set wildignore+=*_rsa,*_rsa.*,*_dsa,*_dsa.*,*_keys,*.pem,*.key,*.gpg


set guifont=monospace
set guioptions-=mTrl


augroup AutoSaveGroup
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  " BufHidden for for compatibility with `set hidden`
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" }}}


" Backup / Swap / Undo {{{

if !isdirectory($HOME . '/.config/nvim/.backup')
    silent !mkdir -p ~/.config/nvim/.backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.config/nvim/.backup/
set backupdir^=./.config/nvim-backup/
set backup

if !isdirectory($HOME . '/.config/nvim/.swap')
    silent !mkdir -p ~/.config/nvim/.swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.config/nvim/.swap//
set directory+=~/.tmp//
set directory+=.

if exists('+undofile')
    if !isdirectory($HOME . '/.config/nvim/.undo')
        silent !mkdir -p ~/.config/nvim/.undo >/dev/null 2>&1
    endif
    set undodir=./.config/nvim-undo//
    set undodir+=~/.config/nvim/.undo//
    set undofile
endif

" }}}
" Local vimrc {{{

set exrc
set secure

" }}}
