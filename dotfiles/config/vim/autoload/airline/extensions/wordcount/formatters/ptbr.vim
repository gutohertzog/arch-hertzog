function! airline#extensions#wordcount#formatters#ptbr#to_string(wordcount)
    let n = a:wordcount
    let s:decimal_group = '.\1'

    " insere pontos a cada 3 dígitos
    let s = substitute(string(n), '\d\zs\(\d\d\d\)\+$', s:decimal_group, 'g')

    let s .= ' W' . g:airline_symbols.space

    if !empty(g:airline_right_alt_sep)
        let s .= g:airline_right_alt_sep . g:airline_symbols.space
    endif

    return s
endfunction

