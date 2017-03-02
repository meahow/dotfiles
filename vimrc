set nocompatible " not vi compatible

"--------------
" Load pathogen
"--------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    colorscheme desert " was solarized
    set guifont=DejaVu\ Sans\ Mono\ 12
elseif &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    colorscheme desert " was solarized
    " customized colors
    highlight SignColumn ctermbg=234
    highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
    highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
    highlight CursorLine ctermbg=235 guibg=Grey40 term=NONE cterm=NONE
    let g:NeatStatusLine_color_normal='ctermfg=64 ctermbg=235 cterm=bold'
    let g:NeatStatusLine_color_insert='ctermfg=136 ctermbg=235 cterm=bold'
    let g:NeatStatusLine_color_replace='ctermfg=160 ctermbg=235 cterm=bold'
    let g:NeatStatusLine_color_visual='ctermfg=33 ctermbg=235 cterm=bold'
    let g:NeatStatusLine_color_position='ctermfg=245 ctermbg=235 cterm=bold'
    let g:NeatStatusLine_color_modified='ctermfg=166 ctermbg=235 cterm=bold'
    let g:NeatStatusLine_color_line='ctermfg=61 ctermbg=235 cterm=bold'
    let g:NeatStatusLine_color_filetype='ctermfg=37 ctermbg=235 cterm=bold'
endif

filetype plugin indent on " enable file type detection

" indentation
set autoindent " auto indentation
set smartindent " c-style code indentation
set expandtab               " place spaces instead of tabs
set tabstop=4               " tabs width, how many spaces is inserted instead of Tab 
set shiftwidth=4            " indent width, Number of spaces to use for each step of (auto)indent. Used for <<, >>  etc.
set softtabstop=4           " soft tabs width, how many spaces is inserted instead of Tab 

"---------------------
" Basic editing config
"---------------------
set number                  " show line numbers
set norelativenumber " no relative line numbering
set incsearch " incremental search (as string is being typed)
set hlsearch " highlight search matches
set list listchars=trail:·,tab:»·,nbsp:⍽ " set list to see tabs and non-breakable spaces TODO: add map for this
set linebreak " break lines on display
"set ruler " show current position in file - obsolete with powerline
set scrolloff=5 " show lines above and below cursor (when possible)
set laststatus=2 " always show status line
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set autochdir " automatically set current directory to directory of last opened file
"set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
set hlsearch                " highlight search match in file
set nowrapscan              " don't wrap on search
set wrap                    " wrap to long lines
set linebreak               " wrap lines at words not characters
set autowrite               " automatically write files when several changing buffers commands are invoked

" smart case-sensitive search
set ignorecase
set smartcase
" tab completion with menu for commands/files/buffers
set wildmode=longest,list,full
set wildmenu
"set mouse+=a " enable mouse mode (scrolling, selection, etc)
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

"--------------------
" Misc configurations
"--------------------

" set leader to ','
let mapleader = ','

" Press space to clear search highlighting and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" If you like "Y" to work from the cursor to the end of line (which is more logical, but not Vi-compatible) use:
:map Y y$

" tags
:se tags+=$MYSB/.tags/tags.ctags

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" toggle relative numbering
nnoremap <C-n> :set rnu!<CR>

" save read-only files
command -nargs=0 Sudow w !sudo tee % >/dev/null

"---------------------
" Plugin configuration
"---------------------

" nerdtree
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" tagbar
nnoremap <Leader>t :TagbarToggle<CR>

" gundo
nnoremap <Leader>u :GundoToggle<CR>

" ctrlp
nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1

" ag
let g:ag_mapping_message=0
command -nargs=+ Gag Gcd | Ag! <args>
nnoremap K :Gag "\b<C-R><C-W>\b"<CR>:cw<CR>
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': []
\}
nnoremap <Leader>s :SyntasticCheck<CR>
nnoremap <Leader>r :SyntasticReset<CR>
nnoremap <Leader>i :SyntasticInfo<CR>
nnoremap <Leader>m :SyntasticToggleMode<CR>

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" incsearch-easymotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" argwrap
nnoremap <Leader>w :ArgWrap<CR>

" markdown
let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'coffee',
    \ 'erb=eruby',
    \ 'javascript',
    \ 'json',
    \ 'perl',
    \ 'python',
    \ 'ruby',
    \ 'yaml',
\]

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
