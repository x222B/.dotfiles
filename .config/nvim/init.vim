" Bootstrap nvim and vim-plug: {{{

if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')
    silent !mkdir -p ~/.config/nvim/autoload >/dev/null 2>&1
    silent !mkdir -p ~/.config/nvim/plugged >/dev/null 2>&1
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                \ >/dev/null 2>&1
endif

let mapleader = "\<Space>"

" }}}

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

let g:plug_url_format = 'https://github.com/%s.git'

" Plug 'morhetz/gruvbox' " forked
Plug 'x222b/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'dense-analysis/ale'

Plug 'airblade/vim-gitgutter'

call plug#end()

" }}}

" Theme {{{

set termguicolors
set background=dark
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
colorscheme gruvbox

" }}}

" Vim Settings {{{

syntax on

set number
set hidden
set cursorline
set list
set mouse=ar
set laststatus=2
set showtabline=2
set tabpagemax=50
set previewheight=5
set noshowmode
set incsearch
set ignorecase
set smartcase
set autoread
set nostartofline
set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
set nowrap
set scrolloff=3
set sidescroll=1
set sidescrolloff=0

set foldmethod=marker

" vim-gitgutter
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '◢'
let g:gitgutter_sign_removed_first_line = '◥'
let g:gitgutter_sign_modified_removed = '┻'
let g:gitgutter_map_keys = 0
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>ha <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" " ALE
let g:ale_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_completion_enabled = 0

"" Use special space: ( ) U+2000 (EN QUAD)
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_info = '●'
let g:ale_sign_hint = '●'


nmap [r <plug>(ale_previous_wrap)
nmap ]r <plug>(ale_next_wrap)
nnoremap <silent> <leader>a :<C-u>ALEToggle <Bar> echo g:ale_enabled ? 'ALE enabled' : 'ALE disabled' <CR>

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

" Mappings {{{

let mapleader = "\<Space>"

nnoremap <Leader>G :Goyo<CR>

" Moving Lines
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv

" Split resize
nnoremap <silent> <C-w>h 10<C-w><
nnoremap <silent> <C-w>j 10<C-w>-
nnoremap <silent> <C-w>k 10<C-w>+
nnoremap <silent> <C-w>l 10<C-w>>

" Remove trailing whitespaces
nnoremap <silent> <F3> :call TrimWhitespace() <CR>

" Save file
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" }}}

" Functions {{{

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

function! s:goyo_enter()
	Limelight
	let &l:statusline = '%M'
	hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
	Limelight!
endfunction

" }}}

" autocmd {{{

augroup AutoSaveGroup
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

augroup SaveTrimWhitespace
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup end

augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

augroup GitGutterUpdate
    autocmd!
    autocmd BufWritePost * GitGutter
augroup END


" }}}

" Local vimrc {{{

set exrc
set secure

" }}}

