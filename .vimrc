execute pathogen#infect()
syntax on
filetype plugin indent on
let python_highlight_all = 1
set nu

runtime! plugin/sensible.vim
set listchars=eol:$
if has('persistent_undo')
  set noundofile
endif
