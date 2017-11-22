" load plugins
execute pathogen#infect()
execute pathogen#helptags()

" color scheme
let g:solarized_termcolors=256
colorscheme Tomorrow-Night-Bright
set background=dark

" leader
let mapleader = ","

" essential settings
set nocompatible
set backspace=2  " backspace over everything in insert mode
set number
set novisualbell
set noerrorbells
set noundofile
set scrolloff=5

" folding (`za` toggles folds)
set foldmethod=indent
set foldlevel=99

" coding settings
syntax on
filetype plugin indent on  " see `:help filetype-overview` for detailed information

" current setting highlights tabs and spaces
set list

" enhanced python syntax highlighting
let python_highlight_all = 1
let python_version_2 = 1  " python 3 highlighting is enabled by default
let g:pyflakes_use_quickfix = 0  " tell pyflakes not to use quick fix window

" buffer settings
set hidden  " make sure that buffers can be hidden
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" tab completion for python code
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" toggles on gundo
map <leader>g :GundoToggle<CR>

" toggles task list (e.g. TODOs in code)
map <leader>td <Plug>TaskList

" search settings
set hlsearch
set incsearch
set ignorecase
set smartcase  " case insensitive searches become sensitive with capitals
map <space> /

" tab settings
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

" most important setting for usability
inoremap jj <Esc>

" set visual line lenght limits
let &colorcolumn="73,80,".join(range(120,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set formatoptions+=t
set textwidth=79

let g:pydoc_cmd = 'python -m pydoc'

" set status line to always be visible
set laststatus=2

" highlight the other parenthesis
highlight MatchParen ctermbg=3

" Treat long lines as break lines (useful when moving around)
map j gj
map k gk

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
" (used often enough to deserve its own command)
command P :setlocal paste!

" Remember info about open buffers on close
set viminfo^=%

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" cursor settings
set cursorline
" use a | cursor in insert mode (works with tmux as well)
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" vim-indent-guides
" Turn on with `:IndentGuidesEnable`.
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=0 ctermfg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235 ctermfg=237

" for syntastic
let g:syntastic_python_checkers = ['pyflakes']

" json options
map <leader>json :%!python -c 'import json, sys; print("\n".join([json.dumps(json.loads(_.strip()), indent=4) for _ in sys.stdin.readlines()]))'
command J :%!python -m json.tool

" spell check for python
"   * zg to add word to word list
"   * zw to reverse
"   * zug to remove word from word list
"   * z= to get list of possibilities
" Note: Actually disabled (enable with `:set spell` before committing
"       new code).
au FileType python set spell spelllang=en_us
highlight clear SpellBad
highlight SpellBad cterm=underline ctermfg=red
highlight clear SpellCap
highlight clear SpellRare
highlight clear SpellLocal
au FileType python set nospell

" sql formatter configs
let g:sqlutil_align_where = 0

" speeeeed
set lazyredraw
set ttyfast

" Uncomment this in case of potential weird new line characters.
" listchars is automatically turned on but will only highlight tabs
" which is immensely useful for python. Adding the eol char is
" distracting. Hence, turned off by default.
"runtime! plugin/sensible.vim
"set listchars=eol:$
