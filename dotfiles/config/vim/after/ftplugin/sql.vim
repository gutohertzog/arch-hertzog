" after/ftplugin/sql.vim
" configurações específicas para SQL

" guarda {{{
" guarda padrão de ftplugin — evita reaplicar se o filetype for resetado
" no mesmo buffer (ex: :set filetype=sql disparado de novo)
if exists('b:did_ftplugin_sql_exec')
    finish
endif
let b:did_ftplugin_sql_exec = 1
" }}}

" dbs.vim {{{
" modelo para o arquivo local/dbs.vim
" let g:sql_servers = {
" \   'dev': 'localhost,1111',
" \   'tst': 'localhost,2222',
" \   'hml': 'localhost,3333'
" \ }
" let g:sql_objects_root = 'C:\caminho\completo\para\sql_objects'
" }}}

" validação dbs.vim {{{
if !isdirectory(g:vimrc_root . '/local')
    call mkdir(g:vimrc_root . '/local',   'p')
endif
if filereadable(g:vimrc_root . '/local/dbs.vim')
    execute 'source ' . g:vimrc_root . '/local/dbs.vim'
endif
" }}}

" tags {{{
" conecta o tags gerado manualmente
if exists('g:sql_objects_root')
    let g:tags_file = g:sql_objects_root . '/tags'
    if filereadable(g:tags_file)
        execute 'setlocal tags+=' . fnameescape(g:tags_file)
    endif
endif
" }}}

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

" funções para comentários {{{
" fold em BEGIN..END e parênteses {{{
function! s:StripStringsAndComments(line)
    let l = a:line
    let l = substitute(l, '--.*$', '', '')     " remove comentário de linha
    let l = substitute(l, "'[^']*'", '', 'g')  " remove strings (aproximado)
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

" funções para execução do SQL {{{
" guarda a saída acumulada e o ambiente/arquivo temp da execução atual
let s:sql_output  = get(s:, 'sql_output', [])
let s:sql_env     = get(s:, 'sql_env', '')
let s:sql_tmpfile = get(s:, 'sql_tmpfile', '')
let s:sql_start   = get(s:, 'sql_start', reltime())

" Ensure SQL Result Buffer {{{
" garante que o buffer de resultado existe, sem trocar de janela/buffer atual
function! s:EnsureSqlResultBuffer() abort
    let l:bufnr = bufnr('__SQL_RESULT__')
    if l:bufnr == -1
        let l:bufnr = bufadd('__SQL_RESULT__')
        call bufload(l:bufnr)
        call setbufvar(l:bufnr, '&buftype',    'nofile')
        call setbufvar(l:bufnr, '&bufhidden',  'hide')
        call setbufvar(l:bufnr, '&swapfile',   0)
        call setbufvar(l:bufnr, '&buflisted',  0)
    endif
    return l:bufnr
endfunction
" }}}

" Show SQL Result Window {{{
" abre a janela do resultado se ainda não estiver visível, mas devolve
" o foco para a janela de onde a query foi disparada (não rouba o cursor)
function! s:ShowSqlResultWindow(bufnr) abort
    if bufwinid(a:bufnr) == -1
        let l:cur_win = win_getid()
        botright 15split
        execute 'buffer ' . a:bufnr
        setlocal nonumber norelativenumber nowrap
        call win_gotoid(l:cur_win)
    endif
endfunction
" }}}

" Write SQL Result {{{
" escreve o conteúdo atual de s:sql_output no buffer, sem trocar de janela
function! s:WriteSqlResult(lines) abort
    let l:bufnr = s:EnsureSqlResultBuffer()
    call setbufvar(l:bufnr, '&modifiable', 1)
    call deletebufline(l:bufnr, 1, '$')
    call setbufline(l:bufnr, 1, a:lines + s:sql_output)
    call setbufvar(l:bufnr, '&modifiable', 0)
endfunction
" }}}

" On SQL Output {{{
" callback: cada linha que o sqlcmd cospe (stdout+stderr já mesclados)
function! s:OnSqlOutput(channel, msg) abort
    call add(s:sql_output, a:msg)
endfunction
" }}}

" On SQL Exit {{{
" callback: processo terminou — atualiza o buffer e avisa, sem mover o foco
function! s:OnSqlExit(job, status) abort
    let l:elapsed = printf('%.3f', reltimefloat(reltime(s:sql_start)))
    let l:msg = [
        \ "\t\t--- executada em " . toupper(s:sql_env) .
            \ ' em ' . l:elapsed . ' segundos ---',
        \ ]
    call s:WriteSqlResult(l:msg)

    if !empty(s:sql_tmpfile)
        call delete(s:sql_tmpfile)
        let s:sql_tmpfile = ''
    endif

    if a:status != 0
        let l:msg_erro = 'sqlcmd retornou erro (status '
        let l:msg_erro .= a:status . ') — confira o painel'
        echohl WarningMsg | echom l:msg_erro | echohl None
    else
        echom 'Execução em ' . toupper(s:sql_env) .
            \ ' finalizada em ' . l:elapsed . 's.'
    endif
endfunction
" }}}

" Cancel SQL {{{
" cancela a execução em andamento, se houver
function! s:CancelSQL() abort
    let l:job = get(s:, 'sql_job', v:null)
    if type(l:job) != v:t_job || job_status(l:job) !=# 'run'
        echo 'Nenhuma execução em andamento.'
        return
    endif

    if g:is_windows
        " mata a árvore inteira (cmd.exe -> sqlcmd.exe)
        let l:pid = job_info(l:job).process
        call system('taskkill /PID ' . l:pid . ' /T /F')
    else
        call job_stop(l:job, 'kill')
    endif

    echohl WarningMsg
    echom 'Execução cancelada localmente. O SQL Server pode levar ' .
        \ 'alguns segundos para encerrar a sessão no servidor.'
    echohl None
endfunction
" }}}

" Execute SQL {{{
" função principal assíncrona
function! s:ExecuteSQL(env, target) range
    if !exists('g:sql_servers') || !has_key(g:sql_servers, a:env)
        let l:msg_erro = 'Ambiente desconhecido ou não configurado : '
        echohl ErrorMsg | echo l:msg_erro . a:env | echohl None
        return
    endif

    " trava: não permite nova execução enquanto uma estiver rodando
    let l:job = get(s:, 'sql_job', v:null)
    if type(l:job) == v:t_job && job_status(l:job) ==# 'run'
        echohl WarningMsg
        echo 'Já existe uma execução em andamento. Aguarde ou cancele.'
        echohl None
        return
    endif

    let current_file = expand('%:p')
    if a:target ==# 'visual'
        let sqlfile = tempname()
        call writefile(getline(a:firstline, a:lastline), sqlfile)
        let s:sql_tmpfile = sqlfile
    else
        let sqlfile = current_file
        let s:sql_tmpfile = ''
    endif

    let l:shell_cmd = 'sqlcmd -S ' . g:sql_servers[a:env] . ' -E -f 65001 -i '
    let l:shell_cmd .= sqlfile . ' 2>&1'

    " invoca o shell explicitamente — garante que o 2>&1 seja interpretado
    " de forma confiável, em vez de depender do parsing interno do job_start
    if g:is_windows
        let l:job_cmd = ['cmd.exe', '/c', l:shell_cmd]
    else
        let l:job_cmd = ['/bin/sh', '-c', l:shell_cmd]
    endif

    let s:sql_output = []
    let s:sql_env    = a:env

    let l:bufnr = s:EnsureSqlResultBuffer()
    call s:ShowSqlResultWindow(l:bufnr)

    let l:msg = [
        \ '',
        \ "\t\t--- executando em " . toupper(a:env) . " ---",
        \ '',
        \ '',
        \ "\t\t<Leader>sx para cancelar",
        \ '',
        \ ]
    call s:WriteSqlResult(l:msg)

    " medidor do tempo de execução
    let s:sql_start = reltime()
    let s:sql_job = job_start(l:job_cmd, {
        \ 'out_cb':  function('s:OnSqlOutput'),
        \ 'exit_cb': function('s:OnSqlExit'),
        \ })
endfunction
" }}}

" }}}

" atalhos {{{
" Atalhos (F4 + nome do servidor) — agora restritos ao buffer SQL
nnoremap <buffer> <F4>dev :call <SID>ExecuteSQL('dev', 'file')<CR>
nnoremap <buffer> <F4>tst :call <SID>ExecuteSQL('tst', 'file')<CR>
nnoremap <buffer> <F4>hml :call <SID>ExecuteSQL('hml', 'file')<CR>
nnoremap <buffer> <F4>con :call <SID>ExecuteSQL('con', 'file')<CR>

xnoremap <buffer> <F4>dev :call <SID>ExecuteSQL('dev', 'visual')<CR>
xnoremap <buffer> <F4>tst :call <SID>ExecuteSQL('tst', 'visual')<CR>
xnoremap <buffer> <F4>hml :call <SID>ExecuteSQL('hml', 'visual')<CR>
xnoremap <buffer> <F4>con :call <SID>ExecuteSQL('con', 'visual')<CR>

nnoremap <buffer> <Leader>sx :call <SID>CancelSQL()<CR>
" }}}

