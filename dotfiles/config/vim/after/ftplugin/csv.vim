" after/ftplugin/csv.vim
" configurações específicas para CSV

setlocal nowrap

" CSV Colors {{{
function! s:CSVColors() abort
    if &background ==# 'dark'
        highlight csvCol1 guifg=#7AA2F7 ctermfg=117
        highlight csvCol2 guifg=#73DACA ctermfg=116
        highlight csvCol3 guifg=#9ECE6A ctermfg=150
        highlight csvCol4 guifg=#E0AF68 ctermfg=179
        highlight csvCol5 guifg=#BB9AF7 ctermfg=141
        highlight csvCol6 guifg=#FF9E64 ctermfg=215
        highlight csvCol7 guifg=#F7768E ctermfg=210
        highlight csvCol8 guifg=#C0CAF5 ctermfg=189
    else
        highlight csvCol1 guifg=#2455A4 ctermfg=25
        highlight csvCol2 guifg=#006D77 ctermfg=30
        highlight csvCol3 guifg=#357A38 ctermfg=28
        highlight csvCol4 guifg=#806000 ctermfg=94
        highlight csvCol5 guifg=#7048A8 ctermfg=54
        highlight csvCol6 guifg=#A84B00 ctermfg=130
        highlight csvCol7 guifg=#A32945 ctermfg=125
        highlight csvCol8 guifg=#505050 ctermfg=240
    endif
endfunction

augroup csv_colors
    autocmd!
    autocmd ColorScheme * call <SID>CSVColors()
augroup END
" }}}

call s:CSVColors()

