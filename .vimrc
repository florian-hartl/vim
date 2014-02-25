execute pathogen#infect()
execute pathogen#helptags()
let g:solarized_termcolors=256
syntax on
set list
set background=dark
colorscheme Tomorrow-Night-Bright
filetype on
filetype plugin indent on
let python_highlight_all = 1
let python_version_2 = 1
set nu
set foldmethod=indent
set foldlevel=99
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
let mapleader = "_"
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
let g:pyflakes_use_quickfix = 0
"let g:pep8_map='<leader>8'
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
set hlsearch incsearch ignorecase
set tabstop=4 noexpandtab shiftwidth=4 softtabstop=4
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set scrolloff=5
set cursorline
set noerrorbells
set novisualbell
inoremap jj <Esc>
" Set off the other paren
highlight MatchParen ctermbg=3

" move lines
nnoremap º :m .+1<CR>==
nnoremap ∆ :m .-2<CR>==
inoremap º <Esc>:m .+1<CR>==gi
inoremap ∆ <Esc>:m .-2<CR>==gi
vnoremap º :m '>+1<CR>gv=gv
vnoremap ∆ :m '<-2<CR>gv=gv

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Return to last edit position when opening files
"autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal! g`\"" |
"     \ endif

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

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

"" doesn't work :/
"" use a | cursor in insert mode
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"

"" use a rectangle cursor otherwise
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"" reset cursor when vim exits
"autocmd VimLeave * silent !echo -ne "\<Esc>]50;CursorShape=0\x7"

runtime! plugin/sensible.vim
"set listchars=eol:$
if has('persistent_undo')
  set noundofile
endif

"pig
augroup filetypedetect 
	au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END

set noundofile
