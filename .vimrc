" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")
set bg:dark
set backspace=2
set expandtab
set shiftwidth=4
set smartcase
set smartindent
set tabstop=4
set nobackup
set pastetoggle=<F11>
set hidden
set showmatch
set whichwrap+=<,>,h,l,[,]
map <F9> :WMToggle<cr>
map <F10> :FirstExplorerWindow<cr>
let g:winManagerWindowLayout = 'BufExplorer|FileExplorer'

augroup perl

    " make tab errors
    autocmd FileType perl match Error /[\t]/

    " make trailing spaces errors
    autocmd FileType perl match Error /\s\+$/

    " make trailing colons errors
    autocmd FileType perl match Error /[\t]\|\s\+$\|:\s*$/


    " autoindent
    autocmd FileType perl set autoindent
    autocmd FileType perl set smartindent

    " check perl code with :make
    autocmd FileType perl set makeprg=perl\ -c\ %\ $*
    autocmd FileType perl set errorformat=%f:%l:%m
    autocmd FileType perl set autowrite

augroup END

" Remove detault mappings
let VCSCommandDisableMappings=1

nmap ,ca :VCSAnn<CR>

" Show 30 last lines from log related to the current file
nmap ,cl :VCSLog<CR>

" Show diffs with version in the CVS
nmap ,cd :VCSDiff<CR>

" Check-in the current version
nmap ,ci :VCSCommit <CR>

" Update current file
nmap ,cu :VCSUpdate <CR>

" Shows the status of the file
nmap ,cs :VCSStatus<CR>

" Remove diff colors
map  ,cc :set nodiff<CR>

" map S to quickly do global search and replace
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>

" set K to search perldoc
set keywordprg=perldoc\ -f

" for Jeff
set nu
set laststatus=2
