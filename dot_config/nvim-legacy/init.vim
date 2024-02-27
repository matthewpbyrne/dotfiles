"" Clean me up


" might nnot need 
" map <Space> <Leader>

" nmap <leader>q :q!<cr>
" nmap <leader>w :w!<cr>
" nmap <leader>x :x!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Default Full-Fat vim configuration  
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO; Add to TODOs:
" * Check out https://github.com/lambdalisue/gina.vim

  " Python
  " TODO: Clean up
    "let g:python3_host_prog = $PYENV_ROOT .  '/versions/py3nvim/bin/python'
    "let g:python_host_prog = $PYENV_ROOT .  '/versions/py2nvim/bin/python'
    " let g:python3_host_prog = '/home/matthew/.local/share/virtualenvs/py3nvim-BOR1eEYn/bin/python'
    " let g:python_host_prog = '/home/matthew/.local/share/virtualenvs/py2nvim-yrGm60nk/bin/python'

  " Misc ---------------------------------
    filetype plugin on    " Enable filetype-specific plugins
    set background=dark
    set number                     " Show current line number
    set relativenumber             " Show relative line numbers
    set tags=.git/tags  " TODO
    "let g:gutentags_ctags_tagfile = '.git/tags'
    let g:gutentags_define_advanced_commands = 1 " TODO
    syntax enable

  " Tabs and Spaces handling
    filetype indent on    " Enable filetype-specific indenting
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4

  " Window Navigation
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show a diff of what's changed since the last save
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
  endif


" Make UltiSnips framework-aware (TODO: Explain better)
    function! s:FASnippets()
      " TODO: Rails, Phoenix etc.
      UltiSnipsAddFiletypes django.python
      echo "UltiSnipsAddFiletypes django.python"
    endfunction
    command! FASnippets :call s:FASnippets()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmp messing: FIXME: Delete
    function! s:MyEnv2()
      echo $LOGNAME
      "echo '$LOGNAME'
    endfunction
    command! MyEnv :call s:MyEnv2()

"noremap <silent> <LocalLeader>m :MyEnv<CR>
"noremap <silent> <LocalLeader>1 :MyEnv<CR>
"noremap <silent> <LocalLeader>n :MyEnv2<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Sources
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" call plug#begin('~/.local/share/nvim/plugged')
"
" General
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'

"" Code Analysis
"Plug 'dense-analysis/ale'
"Plug 'scrooloose/syntastic'
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }

" Getting Around > Navigation with sub-section for ctags
"Plug 'jremmen/vim-ripgrep'  " Is this a subset of fzf-vim? 
"Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
"Plug 'junegunn/fzf.vim'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
"Plug 'majutsushi/tagbar'
"Plug 'scrooloose/nerdtree'
"Plug 't9md/vim-choosewin'
Plug 'tpope/vim-projectionist'

"" Readability
"Plug 'fisadev/fisa-vim-colorscheme'
"Plug 'mhinz/vim-signify'
"
"" Snippets + Code Completions
"Plug 'honza/vim-snippets'
"Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
"Plug 'SirVer/ultisnips'
"
"" Terminal-Integration
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'jpalardy/vim-slime'
"
"" Code Execution + Testing
"Plug 'janko-m/vim-test'
"
"" VCS 
"Plug 'tpope/vim-fugitive'
"

" Text Wrangling / Manipulation
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
"Plug 'mattn/emmet-vim'
""Plug 'Townk/vim-autoclose'

"" Other Plugs TODO 
"Plug 'altercation/vim-colors-solarized'
"Plug 'arielrossanigo/dir-configs-override.vim'
"Plug 'autozimu/LanguageClient-neovim', {
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'davidhalter/jedi-vim'
"Plug 'dense-analysis/ale'
"Plug 'derekwyatt/vim-scala'
"Plug 'dhruvasagar/vim-table-mode'
"Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
"Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
"Plug 'fisadev/fisa-vim-colorscheme'
"Plug 'fisadev/FixedTaskList.vim'
"Plug 'fisadev/vim-ctrlp-cmdpalette'
"Plug 'fisadev/vim-isort'  " this was messing up tab snippet completion in rb
"Plug 'honza/vim-snippets'
"Plug 'janko-m/vim-test'
"Plug 'jeetsukumaran/vim-indentwise'
"Plug 'jpalardy/vim-slime'
"Plug 'jremmen/vim-ripgrep'  " Is this a subset of fzf-vim
"Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
"Plug 'junegunn/fzf.vim'
"Plug 'junegunn/vim-easy-align'
"Plug 'lambdalisue/vim-pyenv'
"Plug 'lilydjwg/colorizer'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'majutsushi/tagbar'
"Plug 'mattn/emmet-vim'
"Plug 'mhinz/vim-signify'
"Plug 'michaeljsmith/vim-indent-object'
"Plug 'mileszs/ack.vim'
"Plug 'myusuf3/numbers.vim'
"Plug 'neomake/neomake'
"Plug 'prettier/vim-prettier', {
"Plug 'python-mode/python-mode', {'branch': 'develop'}
"Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/syntastic'
"Plug 'sheerun/vim-polyglot'
"Plug 'Shougo/context_filetype.vim'
"Plug 'Shougo/neocomplete.vim', {'for': 'haskell'}
"Plug 'Shougo/vimproc.vim', {'do': 'make'}
"Plug 'SirVer/ultisnips'
"Plug 'skywind3000/gutentags_plus'
"Plug 't9md/vim-choosewin'
"Plug 'tell-k/vim-autopep8'
"Plug 'tommcdo/vim-exchange'
"Plug 'tomtom/tcomment_vim'
"Plug 'Townk/vim-autoclose'
"Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-bundler'
"Plug 'tpope/vim-dadbod'
"Plug 'tpope/vim-dispatch'
"Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-fireplace'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-projectionist'
"Plug 'tpope/vim-rails'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-sleuth'
"Plug 'tpope/vim-speeddating'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-unimpaired'
"Plug 'valloric/MatchTagAlways'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-scripts/IndexedSearch'
"Plug 'vim-scripts/YankRing.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" abolish.vim --------------------------

" AutoClose ----------------------------

" Choosewin ----------------------------
    nmap - <Plug>(choosewin)

" Dense Analysis -----------------------
    let g:ale_fix_on_save = 1
    " Get local autopep8 working:
    let g:ale_fixers = {
          \   '*': ['remove_trailing_lines', 'trim_whitespace'],
          \   'javascript': ['eslint'],
          \   'python': ['isort', 'black'],
          \}
    function! s:ToggleAleFixOnSave()
      let g:ale_fix_on_save = !g:ale_fix_on_save
      if g:ale_fix_on_save
        echo "g:ale_fix_on_save ON"
      else
        echo "g:ale_fix_on_save OFF"
      endif
    endfunction
    command! AutoFixOnSaveToggle :call s:ToggleAleFixOnSave()
    "let g:ale_python_black_use_global = 1 " Am I needed?

    function! s:ToggleDebugger()
      let line_no = line('.')
      let debugger_code='import pdb; pdb.set_trace()'

      if (getline('.')=~ debugger_code )
        "echom "if"
        exe line_no . 'd'
      else
        "echom "nope!"
        exe line_no . 's/\(\s*\)\(\S\)/\1' . debugger_code . '\r\1\2'
      endif
    endfun
    command! ToggleDebugger :call s:ToggleDebugger()

    function! s:MyEnvPrinter()
      echo 'PYENV_ROOT: ' $PYENV_ROOT
      echo 'foos: ' $fooU ' : ' $foox ' : ' $foog
      echo 'bars: ' $barU ' : ' $barx ' : ' $barg
    endfunction
    command! MyEnvPrinter :call s:MyEnvPrinter()


" Deoplete -----------------------------
  " TODOs:
  " 1. figure out how to read other buffers from the get-go
  " 2. figure out if context_filetype is needed
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_ignore_case = 1
    let g:deoplete#enable_smart_case = 1
  " needed so deoplete can auto select the first suggestion
    "set completeopt+=noinsert " Original version
    "set completeopt+=
  " comment this line to enable autocompletion preview window
  " (displays documentation related to the selected completion option)
    "set completeopt-=preview
  " autocompletion of files and commands behaves like shell
  " (complete only the common part, list the options that match)
    set wildmode=list:longest

    " TODO:
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" dispatch.vim -------------------------

" EasyAlign ----------------------------
  " Start for visual mode and motion objects:
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

" eunuch.vim ---------------------------

" exchange.vim -------------------------

" fisa-colorscheme ---------------------

" fugitive.vim -------------------------

" fzf ----------------------------------
  " Figure out how I invoke this?
  command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" fzf-vim ------------------------------

" NERDCommenter ------------------------

" NERDTree -----------------------------

" projectionist.vim --------------------

" repeat.vim ---------------------------

" RipGrep ------------------------------

" Signify ------------------------------
  " Guessing order for vcs:
    let g:signify_vcs_list = [ 'git', 'hg' ]
  " nicer colors
    highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
    highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
    highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
    highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
    highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
    highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" sleuth.vim ---------------------------

" Slime --------------------------------
    let g:slime_target = 'tmux'

" speeddating.vim ----------------------

" surround.vim -------------------------

" Syntastic ----------------------------

" tcomment -----------------------------

" UltiSnips ----------------------------

    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsListSnippets="<c-l>"

    "let g:UltiSnipsSnippetsDir = '~/.config/nvim/ultisnips-private'
    "let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/ultisnips', '~/.config/nvim/ultisnips-private']
    " TODO: Get working properly for local
    "let g:UltiSnipsSnippetDirectories = ['~/.local/share/nvim/plugged/vim-snippets/UltiSnips']
    "let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/ultisnips-private', '~/.config/nvim/ultisnips']

" unimpaired.vim -----------------------

" Vim Snippets -------------------------

" Vim Tmux Navigator -------------------

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  let mapleader="\<Space>"
  let maplocalleader="\\"

  " <Leader>g -- git grep for something (mnemonic: [g]it [g]rep).
    " nnoremap <Leader>g :VcsJump grep<Space> " TODO

  " filepaths
    nnoremap <LocalLeader>p :echo expand('%')<CR>
    " nnoremap <Leader>pp :let @0=expand('%') <Bar> :Clip<CR> :echo expand('%')<CR> " TODO Fix

  " <Leader><Leader> -- Open last buffer.
    nnoremap <Leader><Leader> <C-^>
    nnoremap <Leader>e :edit!<CR>
    nnoremap <Leader>o :only<CR>
    nnoremap <Leader>q :quit<CR>
    nnoremap <Leader>w :write<CR>
    nnoremap <Leader>x :xit<CR>

" --------------------------------------
" Custom Functions ---------------------
" --------------------------------------
  " <LocalLeader>d... -- Diff mode bindings:
    noremap <silent> <LocalLeader>do :DiffOrig<CR>
  " - yof: toggle auto-fix on saving (mnemonic: [f] = fix)
    noremap <silent> yof :AutoFixOnSaveToggle<CR>
  " - yoa: toggle autocomplete (deoplete) (mnemonic: [a] = autocomplete)
    noremap <silent> yoa :call deoplete#toggle()<CR>

    "autocmd FileType js autocmd BufWritePre <buffer> %!python -m json.tool 2>/dev/null || echo <buffer>

    nmap <silent> <leader>b :ToggleDebugger<CR>
    " FIXME - this is temporary:
    nmap <silent> <LocalLeader>v :MyEnvPrinter<CR>

" --------------------------------------
" Plugins ------------------------------
" --------------------------------------

" abolish.vim --------------------------

" AutoClose ----------------------------
  " - yop: toggle bracket auto-closing (mnemonic: [p] = parenthesis)
    "noremap <silent> yop :AutoCloseToggle<CR>

" Choosewin ----------------------------

" Dense Analysis -----------------------

" Deoplete -----------------------------

" dispatch.vim -------------------------

" EasyAlign ----------------------------

" eunuch.vim ---------------------------

" exchange.vim -------------------------

" fisa-colorscheme ---------------------

" fugitive.vim -------------------------
  " <LocalLeader>d... -- Diff mode bindings:
  " - <LocalLeader>dd: show diff view (mnemonic: [d]iff)
  " - <LocalLeader>dp: show diff to HEAD view (mnemonic: [p]rior)
  " - <LocalLeader>dh: choose hunk from left (mnemonic: [h] = left)
  " - <LocalLeader>dl: choose hunk from right (mnemonic: [l] = right)
  "
  " <LocalLeader>g... -- Git bindings:
  " - <LocalLeader>gw: State file (mnemonic: [w]rite)
    " Check about 3 way splits.
    " Check if should be `:Git Status`:
    nnoremap <silent> <LocalLeader>s :Gstatus<CR>
    nnoremap <silent> <LocalLeader>dd :Gvdiffsplit<CR>
    nnoremap <silent> <LocalLeader>dp :Gvdiffsplit HEAD<CR>
    nnoremap <silent> <LocalLeader>dh :diffget //2<CR>
    nnoremap <silent> <LocalLeader>dl :diffget //3<CR>
    nnoremap <silent> <LocalLeader>gc :Git commit<CR>
    nnoremap <silent> <LocalLeader>gw :Gwrite<CR>

" fzf ----------------------------------

" fzf-vim ------------------------------
  " file finder mapping
    "nmap <LocalLeader>e :Files<CR>  " This is WIP
    nmap <LocalLeader>e :FZF<CR>
  " tags (symbols) in current file finder mapping
    nmap <LocalLeader>g :BTag<CR>
  " tags (symbols) in all files finder mapping
    nmap <LocalLeader>G :Tag<CR>
  " general code finder in current file mapping
    nmap <LocalLeader>f :BLines<CR>
  " general code finder in all files mapping
    nmap <LocalLeader>F :Lines<CR>
  " commands finder mapping
    nmap <LocalLeader>c :Commands<CR>
  " maps finder mapping
    "nmap <LocalLeader>m :Maps<CR>

" NERDCommenter ------------------------

" NERDTree -----------------------------
    nmap <leader>n :NERDTreeFind<CR>
    nmap <leader>m :NERDTreeToggle<CR>

" projectionist.vim --------------------

" repeat.vim ---------------------------

" RipGrep ------------------------------
    " Not sure if needed when hasve fzf.vim
    " Maybe have case sensitive search too?
    nmap <LocalLeader>r :Rg -i<Space>
    nmap <LocalLeader>re :Rg <Space>
    nmap <LocalLeader>wr :Rg <cword><CR>
    nmap <LocalLeader>wir :Rg <cword><CR>

" Signify ------------------------------

" sleuth.vim ---------------------------

" Slime --------------------------------

" speeddating.vim ----------------------

" surround.vim -------------------------

" Syntastic ----------------------------

" tcomment -----------------------------

" test.vim

let test#strategy = "neovim"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" UltiSnips ----------------------------

" unimpaired.vim -----------------------

" Vim Snippets -------------------------

" Vim Tmux Navigator -------------------


" TODO: Get working
"let g:gutentags_file_list_command = {'markers': {'.pythontags': '~/python_file_lister.py'}}
"let g:gutentags_ctags_executable_python = '~/python_file_lister.py'

" TODO Use: $ASDF_USER_SHIMS
" Get working with just `pyls` etc.
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/home/matthew/.asdf/shims/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['~/.pyenv/versions/py3nvim/bin/pyls'],
    \ 'scala': ['metals-vim']
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

