" CREATION     : 2015-12-26
" MODIFICATION : 2015-12-26

" VARIABLES =============================
" Fullscreen toggling command {{{1
let s:cmd = 'wmctrl -r ":ACTIVE:" -b toggle,fullscreen'
" Window state by default {{{1
let s:winState = 'normal'
" 1}}}

" FUNCTIONS =============================
function! s:GetWinProp() abort " {{{1
	" Returns the window's properties.
	" [guioptions, width, height, x, y]

	let [l:columns, l:lines] = [&columns, &lines]
	let [l:posX, l:posY] = [getwinposx(), getwinposy()]
	let l:guiOpt = has('gui_running') ? &guioptions : ''
	return [l:guiOpt, l:columns, l:lines, l:posX, l:posY]
endfunction
function! vullScreen#Toggle() abort " {{{1
	if s:winState ==# 'normal'
		let s:winProp = s:GetWinProp()
		set guioptions-=m
		set guioptions-=T
		call system(s:cmd)
		wincmd =
		let s:winState = 'fullscreen'
	else
		call system(s:cmd)
		let &guioptions = s:winProp[0]
		let [&columns, &lines] = [s:winProp[1], s:winProp[2]]
		execute 'winpos ' . s:winProp[3] . ' ' . s:winProp[4]
		wincmd =
		let s:winState = 'normal'
	endif
endfunction
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
