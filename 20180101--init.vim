let g:python3_host_prog = '/usr/bin/python3'

set termguicolors
set number                     " Show current line number
set relativenumber             " Show relative line numbers

call plug#begin('~/.local/share/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-easy-align'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'

Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install -g',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

  
call plug#end()

filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

let mapleader=","

" Theme
syntax enable
set background=dark
colorscheme solarized


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" To show the diff since the last save
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

""" Python formatting
nmap <Leader>p :PymodeLintAuto<CR>
nmap <Leader>8 :PymodeLint<CR>

let g:pymode_rope = 1

""" Slime Config
let g:slime_target = "tmux"

""" CtrlP
nnoremap <leader>. :CtrlPTag<cr>

