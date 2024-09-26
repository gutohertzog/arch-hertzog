" Configurações específicas do Python

set shiftwidth=4
set tabstop=4
set softtabstop=4
set foldmethod=indent
" set textwidth=79

let python_highlight_all=1

nmap <F5> :w <CR> :!clear; python % <CR>
nmap <F6> :w <CR> :!python %<Space>

" define a cor vermelha para as coisas ruins
highlight BadWhitespace ctermbg=red guibg=red

" destaca as tabulações como ruim
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" detaca os espaços em branco no final da linha
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

