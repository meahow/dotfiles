set nocompatible	    " niekompatybilny z VI
set laststatus=2	    " zawsze pokazuj linie statusu
set incsearch               " incremental search
"set vb t_vb=               " don't beep nor flash on error
set showmatch               " show matching bracket
set hlsearch                " highlight search match in file
set number                  " show line numbers
set expandtab               " place spaces instead of tabs
set shiftwidth=4            " indent width, Number of spaces to use for each step of (auto)indent. Used for <<, >>  etc.
set softtabstop=4           " soft tabs width, how many spaces is inserted instead of Tab 
set tabstop=4               " tabs width, how many spaces is inserted instead of Tab 
set nowrapscan              " don't wrap on search
set ruler		    " show the cursor position all the time
set wrap                    " wrap too long line
set linebreak               " wrap lines at words not characters
set autowrite               " automatically write files when several changing buffers commands are invoked

" indentation
set autoindent
set smartindent

" syntax highlighting
syntax enable
colors desert

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

"" highlight the current cursor line
"set cursorline
"" and set its color
"hi CursorLine   cterm=reverse guibg=darkred guifg=white
""hi CursorLine   cterm=NONE ctermbg=darkcyan ctermfg=white guibg=darkred guifg=white
""hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Press space to clear search highlighting and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>
" If you like "Y" to work from the cursor to the end of line (which is more logical, but not Vi-compatible) use:
:map Y y$


if has("autocmd")
 " Enabled file type detection
 " Use the default filetype settings. If you also want to load indent files
 " to automatically do language-dependent indenting add 'indent' as well.
 filetype plugin on
 filetype indent on
endif

"au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null" 
au FileType c exe ":syntax on"
au FileType cpp exe ":syntax on"
au FileType cc exe ":syntax on"
au FileType h exe ":syntax on"
au FileType hh exe ":syntax on"
au FileType hpp exe ":syntax on"

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

se guifont=DejaVu\ Sans\ Mono\ 9

" tags
:se tags+=$MYSB/.tags/tags.ctags

"""" -------old stuff from TR -  for solaris csh
"""" terminal
"""set term=xtermc
"""
""":imap <Esc>Oq 1
""":imap <Esc>Or 2
""":imap <Esc>Os 3
""":imap <Esc>Ot 4
""":imap <Esc>Ou 5
""":imap <Esc>Ov 6
""":imap <Esc>Ow 7
""":imap <Esc>Ox 8
""":imap <Esc>Oy 9
""":imap <Esc>Op 0
""":imap <Esc>On .
""":imap <Esc>OQ /
""":imap <Esc>OR *
""":imap <Esc>Ol +
""":imap <Esc>OS -
