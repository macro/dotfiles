nmap <C-c><C-d> :r !date "+\%Y\%m\%d"<CR>
set tags=tags

set foldmethod=indent
set number
set ai
set viminfo='20,\"50
syntax on

filetype on
filetype plugin on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=2
set smarttab
set showmatch

autocmd FileType python call SetPython()
function! SetPython() 
    colorscheme elflord
    setlocal keywordprg=pydoc
    setlocal makeprg=python\ %   
    setlocal errorformat=%+G\ \ File\ \"%f\"\\,\ line\ %l\\,\ in\ %m
    nmap <C-c><C-c> :!pyflakes %
    nmap <C-c><C-t> :!nosetests %
    autocmd BufWritePre *.py %s/\s\+$//e
    abbreviate prd print "*** [DEBUG]
    abbreviate pdb import pdb; pdb.set_trace()
    highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endfunction
