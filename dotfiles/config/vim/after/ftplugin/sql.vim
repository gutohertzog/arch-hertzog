" configurações específicas do SQL

" configurações {{{
" setlocal foldexpr=SqlFoldLevel(v:lnum)
setlocal foldexpr=SqlFold(v:lnum)
setlocal foldlevel=1
setlocal foldmethod=expr
" }}}

" destaque tabulações {{{
" define a cor vermelha para as coisas ruins
highlight BadWhitespace ctermbg=red guibg=red

" destaca as tabulações como ruim
call matchadd('BadWhitespace', '\t')
" detaca os espaços em branco no final da linha
call matchadd('BadWhitespace', '\s\+$')
" }}}

" funções {{{
" fold em BEGIN..END e parênteses {{{
function! s:StripStringsAndComments(line)
    let l = a:line
    let l = substitute(l, '--.*$', '', '')        " remove comentário de linha
    let l = substitute(l, "'[^']*'", '', 'g')      " remove strings (aproximado)
    return l
endfunction

function! s:LineDelta(line)
    let l = s:StripStringsAndComments(a:line)
    let delta = 0

    if l =~? '\<begin\>' && l !~? '\<begin\s\+\(tran\|transaction\)\>'
        let delta += 1
    endif
    if l =~? '\<end\>\s*;\?\s*$'
        let delta -= 1
    endif

    let opens  = len(substitute(l, '[^(]', '', 'g'))
    let closes = len(substitute(l, '[^)]', '', 'g'))
    let delta += opens - closes

    return delta
endfunction

function! SqlFoldLevel(lnum)
    if !exists('b:sql_fold_tick') || b:sql_fold_tick != b:changedtick
        let b:sql_fold_tick = b:changedtick
        let b:sql_fold_levels = []
        let depth = 0
        for i in range(1, line('$'))
        let line = getline(i)
        if line =~? '^\s*$'
            call add(b:sql_fold_levels, -1)
            continue
        endif
        let depth += s:LineDelta(line)
        call add(b:sql_fold_levels, depth)
        endfor
    endif
    return get(b:sql_fold_levels, a:lnum - 1, 0)
endfunction
" }}}

" fold BEGIN..END {{{
function! SqlFold(lnum)
    let line = getline(a:lnum)

    " ignora linhas em branco
    if line =~? '^\s*$'
        return '-1'
    endif

    " ignora comentários de linha simples
    if line =~? '^\s*--'
        return '='
    endif

    " abre um nível em BEGIN (mas não em BEGIN TRAN/TRANSACTION)
    if line =~? '\<begin\>' && line !~? '\<begin\s\+\(tran\|transaction\)\>'
        return 'a1'
    endif

    " fecha um nível em END (mas não em END TRY/CATCH isolados se quiser tratá-los separado)
    if line =~? '^\s*end\>' || line =~? '\<end\>\s*;\?\s*$'
        return 's1'
    endif

    return '='
endfunction
" }}}
" }}}

