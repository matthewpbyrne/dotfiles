" Fisa-nvim-config
" http://nvim.fisadev.com
" version: 10.0

" TODO current problems:
" * end key not working undef tmux+fish

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

"""" Temporary measure - the other Python stuff largely gets in the way
Plug 'python-mode/python-mode', {'branch': 'develop'}

" Now the actual plugins:

"Plug 'prettier/vim-prettier', {
  "\ 'do': 'npm install',
  "\ 'for': ['ruby'] }


" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Better file browser
Plug 'scrooloose/nerdtree'

" Class/module browser
Plug 'majutsushi/tagbar'
" TODO known problems:
" * current block not refreshing

" TODO: Try again later once other issues are solved
" Search results counter
"Plug 'vim-scripts/IndexedSearch'

" Tmux enhancement
Plug 'jpalardy/vim-slime'

" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code and files fuzzy finder
" Plug 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
" Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'

" Async autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" TODO
" Python autocompletion
"Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
"" Just to add the python go-to-definition and similar features, autocompletion
"" from this plugin is disabled
"Plug 'davidhalter/jedi-vim'

"Plug 'lambdalisue/vim-pyenv'
  "Plug 'davidhalter/jedi-vim'

" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'

" tpope goodies
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Practically a tpope-esque goodie
Plug 'tommcdo/vim-exchange'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Better language packs
Plug 'sheerun/vim-polyglot'

" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" TODO is there a way to prevent the progress which hides the editor?

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" TODO is there a better option for neovim?

" Window chooser
Plug 't9md/vim-choosewin'

" Python support
" Automatically sort python imports
" Plug 'fisadev/vim-isort'  " this was messing up tab snippet completion in rb
"Plug 'tell-k/vim-autopep8'

" Haskell
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/neocomplete.vim', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}


" Highlight matching html tags
Plug 'valloric/MatchTagAlways'

" Generate html in a simple way
Plug 'mattn/emmet-vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" Linters
Plug 'neomake/neomake'
" TODO is it running on save? or when?
" TODO not detecting errors, just style, is it using pylint?

" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'


" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Test helper
Plug 'janko-m/vim-test'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

let mapleader = "\<Space>"


nnoremap <C-J> <C-W><C-J>


" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars+=vert:\

" use 256 colors when possible
" if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
" 	let &t_Co = 256
"     colorscheme fisa
" else
"     colorscheme delek
" endif

" Theme
syntax enable
set background=dark
" colorscheme solarized

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"

" tab navigation mappings
map tt :tabnew
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" window navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of all files
"autocmd BufWritePre * :%s/\s\+$//e
fun! StripTrailingWhiteSpace()
  " don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * :call StripTrailingWhiteSpace()
au Bufread,BufNewFile *.md set filetype=markdown


" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash

" ============================================================================
" Haskell Settings
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" ============================================================================
" Python Settings
" Not sure if this should be in plugins?   TODO

let g:python_host_prog = '/home/matthew/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/matthew/.pyenv/versions/neoneovim3.5/bin/python'


" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" TODO: These first 2 mappings are deletion candidates
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>

nmap ,n :NERDTreeFind<CR>
nmap ,m :NERDTreeToggle<CR>
"nmap <leader>n :NERDTreeFind<CR>
"nmap <leader>m :NERDTreeToggle<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake!

" Python:

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

"let g:neomake_python_pylint_args = neomake

"let g:neomake_python_pylint_args = ["--load-plugins",
""pylint_django"] + neomake#makers#ft#python#pylint()['args']
"let g:neomake_python_pylint_args = ["-d", "missing-docstring,invalid-name"] + neomake#makers#ft#python#pylint()['args']

let g:neomake_python_enabled_makers = ['pylint']


" AutoPEP8 ------------------------------

""" Python formatting
autocmd FileType python nmap <Leader>p :PymodeLintAuto<CR>
autocmd FileType python nmap <Leader>8 :PymodeLint<CR>

let g:pymode_python = 'python3'

let g:pymode_doc = 1
let g:pymode_rope = 1
let g:pymode_virtualenv = 1  "TODO

"let g:pymode_lint_checkers = ['pylint']


"autocmd FileType python noremap <buffer> <leader>8 :call Autopep8()<CR>

" Note that the difference between the above and
" `nmap <leader>8 :call Autopep8()<CR>`
" seems to be that the latter does not respect visual ranges

" TODO: This can be deleted
"command -range=% Autopep8  <line1>,<line2>call Autopep8()

let g:autopep8_diff_type='vertical'

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tag<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" commands finder mapping
nmap ,c :Commands<CR>
" to be able to call CtrlP with default search text
"function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    "execute ':CtrlP' . a:ctrlp_command_end
    "call feedkeys(a:search_text)
"endfunction
" same as previous mappings, but calling with current word as default text
"nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
"nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
"nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
"nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
"nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
"nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
"nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>


" Deoplete -----------------------------

" Use deoplete.

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack
nmap ,wr :Ack <cword><CR>

" Slime -----------------------------

let g:slime_target = "tmux"

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

" Fix for yankring and neovim problem when system has non-text things copied
" in clipboard
let g:yankring_clipboard_monitor = 0
let g:yankring_history_dir = '~/.config/nvim/'

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on docs/fancy_symbols.rst)
"if !exists('g:airline_symbols')
   "let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'

" test.vim

let test#strategy = "neovim"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Simple calcs  (deletion candidate)
" http://vimcasts.org/episodes/simple-calculations-with-vims-expression-register/
nnoremap Q 0yt=A<C-r>=<C-r>"<CR><Esc>

" UltiSnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnips"]
let g:UltiSnipsSnippetsDir='~/.config/nvim/after/mysnips'

" Changes post 20190415
"perl WIP
map <F5> :setlocal makeprg=perl\ -c\ %\|make<CR>
map <F6> :setlocal makeprg=perl\ %\|make<CR>
