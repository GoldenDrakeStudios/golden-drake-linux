" ~/.vimrc

" if started as "evim", exit (evim.vim took care of these settings)
if v:progname =~? "evim"
  finish
endif

" source default vim settings
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" highlight the last used search pattern
if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

" add optional packages
if has('syntax') && has('eval')
  packadd! matchit " makes % command work better (not backward-compatible)
endif

set number        " show line numbers
set expandtab     " replace tabs with spaces (to insert tab: Ctrl+V then Tab)
set tabstop=2     " size of tabs
set softtabstop=2 " size of tabs-replaced-by-spaces
set shiftwidth=2  " size of auto-indent, etc.
set autoindent smartindent
set ignorecase smartcase " case-insensitive search unless using capital letters
