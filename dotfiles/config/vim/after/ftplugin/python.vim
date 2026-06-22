" configurações específicas do Python

" ativa highlight do Vim Runtime
let g:python_highlight_all=1
let g:python_space_error_highlight=1

" configurações {{{
setlocal foldmethod=indent
setlocal textwidth=79
" }}}

" atalhos {{{
nnoremap <F5> :w<CR>:bel term python %<CR>
nnoremap <F6> :w<CR>:bel term python %<Space>
" }}}

" destaque tabulações {{{
" define a cor vermelha para as coisas ruins
highlight BadWhitespace ctermbg=red guibg=red

" destaca as tabulações como ruim
call matchadd('BadWhitespace', '\t')
" detaca os espaços em branco no final da linha
call matchadd('BadWhitespace', '\s\+$')
" }}}
