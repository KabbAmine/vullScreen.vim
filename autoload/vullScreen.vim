" last modification : 2015-12-26


" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	        	svars
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Default window's state {{{1
let s:win_state = 'normal'
" 1}}}

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	        	main
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! vullScreen#toggle() abort " {{{1
    let win_state = get(s:, 'win_state', 'normal')
    if win_state is# 'normal'
        call vullScreen#enable()
    else
        call vullScreen#disable()
    endif
endfun
" 1}}}

fun! vullScreen#enable() abort " {{{1
    let s:win_props = s:get_win_props()
    set guioptions-=m
    set guioptions-=T
    call system(s:get_wmctrl_cmd('add'))
    silent wincmd =
    let s:win_state = 'fullscreen'
endfun
" 1}}}

fun! vullScreen#disable() abort " {{{1
    call system(s:get_wmctrl_cmd('remove'))
    if !exists('s:win_props')
        return
    endif
    let &guioptions = s:win_props[0]
    let [&columns, &lines] = [s:win_props[1], s:win_props[2]]
    silent execute 'winpos ' . s:win_props[3] . ' ' . s:win_props[4]
    silent wincmd =
    let s:win_state = 'normal'
endfun
" 1}}}

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	        	helpers
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:get_wmctrl_cmd(prop) abort " {{{1
    return printf('wmctrl -r ":ACTIVE:" -b %s,fullscreen', a:prop)
endfun
" 1}}}

fun! s:get_win_props() abort " {{{1
    " Returns the properties of the current vim window
    " [guioptions, width, height, x, y]

    let [columns, lines] = [&columns, &lines]
    let [pos_x, pos_y] = [getwinposx(), getwinposy()]
    let gui_opts = has('gui_running') ? &guioptions : ''
    return [gui_opts, columns, lines, pos_x, pos_y]
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
