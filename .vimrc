" cr means enter (run it)
" WarningMsg ErrorMsg

" enable powerline symbols for airline
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1

" set airline theme
let g:airline_theme='simple'

set backup " keep backup file
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" set spell spelllang=en_us

" splits open at the bottom and right
set splitbelow splitright

" numbered lines
set number

" show title
set title

" enable filetype
" filetype plugin on
" filetype plugin indent on

" syntax highlighting
syntax on

" fix delay
set ttimeoutlen=5

" ibeam insert cursor for st and some other terms
let &t_SI = "\<Esc>[6 q" " insert mode
let &t_SR = "\<Esc>[4 q" " replace mode
let &t_EI = "\<Esc>[2 q" " normal mode

" space as leader
let mapleader = " "

" toggle spell checker
map <leader>o :setlocal spell! spelllang=en_us<CR>

" copy to wayland clipboard
map <leader>c :w !wl-copy -p<CR><CR>:echohl ErrorMsg<bar>echo "Copied to clipboard"<bar>echohl None<CR><CR>

" TODO cut to wayland clipboard
" map <leader>c :w !wl-copy -p<CR><CR>:echohl ErrorMsg<bar>echo "Copied to clipboard"<bar>echohl None<CR><CR>

" paste from wayland clipboard and newlines
map <leader>p :r!wl-paste -p<CR><CR>:%s/^M//<CR><CR>

" simple write file bind, spacebar twice
map <leader><leader> :w<CR>

" disable recording
map q <Nop>

" Binary to hex
map <leader>h :%!xxd<CR><CR>
" Hex back to binary
map <leader>b :%!xxd -r<CR><CR>

" Rebind shitty ctrl binds to leader (space)
" Page down
map <leader>J <C-F>
" Page half down
map <leader>j <C-D>
" Page up
map <leader>K <C-B>
" Page half up
map <leader>k <C-U>

" Easy pane movement
map <leader>w <C-W>

" Wal colors
source ~/.cache/wal/colors-wal.vim

" set tabstop=4
" set shiftwidth=4
" set noexpandtab

" %retab!

" Make vimdiff readable
if &diff
	syntax off
endif
