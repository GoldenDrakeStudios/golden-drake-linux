" ~/.vimrc

" if started as "evim", exit (evim.vim has taken care of these settings)
if v:progname =~? "evim"
  finish
endif

" source default vim settings
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup   " do not keep a backup file, use versions instead
else
  set backup     " keep a backup file
  if has('persistent_undo')
    set undofile " allow changes to be undone even after closing/reopening
  endif
endif

if &t_Co > 2 || has("gui_running")
  set hlsearch " highlight the last used search pattern
endif

augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
augroup END

" add optional packages
if has('syntax') && has('eval')
  packadd! matchit " makes % command work better (not backward-compatible)
endif

set expandtab     " replace tabs with spaces (to insert tab: Ctrl+V then Tab)
set softtabstop=2 " size of tabs-replaced-by-spaces
set shiftwidth=2  " size of auto-indent, etc.
set tabstop=4     " size of actual tab characters
set autoindent smartindent
set ignorecase smartcase " case-insensitive search unless using capital letters
set cmdheight=2 " command window height
set number      " show line numbers

colorscheme slate
