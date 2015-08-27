" Full-screen mode in GNU/Linux.
" Version: 0.5

" Creation     : 2014-09-16
" Modification : 2015-08-27
" Maintainer   : Kabbaj Amine <amine.kabb@gmail.com>
" License      : This file is placed in the public domain.


" Vim options {{{1
if exists('g:vullscreen_loaded') || !has('unix')
    finish
endif
let g:vullscreen_loaded = 1

" To avoid conflict problems.
let s:saveCpoptions = &cpoptions
set cpoptions&vim
" 1}}}

" Main command {{{1
command! -bar VullScreen
			\ if executable('wmctrl')
				\| call s:VullScreen()
			\| else
				\| echoerr '"wmctrl" is required, please see http://tomas.styblo.name/wmctrl/'
			\| endif
" Mappings {{{1
let s:vullscreenKey = !exists('g:vullscreen_key') ? '<F11>' : g:vullscreen_key
execute 'nnoremap ' . s:vullscreenKey . ' :VullScreen<CR>'
execute 'inoremap ' . s:vullscreenKey . ' <C-o>:VullScreen<CR>'
" 1}}}

" VARIABLES =============================
" Fullscreen toggling command {{{1
let s:fullScreenCmd = 'wmctrl -r ":ACTIVE:" -b toggle,fullscreen'
" Window state by default {{{1
let s:winState = 'normal'
" 1}}}

" FUNCTIONS =============================
function s:GetWinProp() " {{{1
	" Returns the window's properties.
	" [guioptions, width, height, x, y]

	let [l:columns, l:lines] = [&columns, &lines]
	let [l:posX, l:posY] = [getwinposx(), getwinposy()]
	let l:guiOpt = has('gui_running') ? &guioptions : ''
	return [l:guiOpt, l:columns, l:lines, l:posX, l:posY]
endfunction
function s:VullScreen() " {{{1
	if s:winState ==# 'normal'
		let s:winProp = s:GetWinProp()
		set guioptions-=m
		set guioptions-=T
		call system(s:fullScreenCmd)
		execute "normal \<C-w>="
		let s:winState = 'fullscreen'
	else
		call system(s:fullScreenCmd)
		let &guioptions = s:winProp[0]
		let [&columns, &lines] = [s:winProp[1], s:winProp[2]]
		execute 'winpos ' . s:winProp[3] . ' ' . s:winProp[4] . ''
		execute "normal \<C-w>="
		let s:winState = 'normal'
	endif
endfunction
" 1}}}

" Restore default vim options {{{1
let &cpoptions = s:saveCpoptions
unlet s:saveCpoptions
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
