" Full-screen mode in GNU/Linux.
" Version: 0.1

" Creation     : 2014-09-16
" Modification : 2014-09-16
" Maintainer   : Kabbaj Amine <amine.kabb@gmail.com>
" License      : This file is placed in the public domain.


if exists("g:vullscreen_loaded") || !has('unix')
    finish
endif
let g:vullscreen_loaded = 1

" To avoid conflict problems.
let s:saveCpoptions = &cpoptions
set cpoptions&vim

" COMMANDS =============================
command! VullScreen call s:VullScreen()

" MAPPINGS =============================
" {
if !exists('g:vullscreen_key')
	let g:vullscreen_key = '<F11>'
endif

execute "nmap ".g:vullscreen_key." :VullScreen<CR>"
execute "imap ".g:vullscreen_key." <C-o>:VullScreen<CR>"
" }

" VARIABLES =============================
" {
" Fullscreen toggling command.
let s:FullScreenCmd = {
			\"unix": "wmctrl -r \":ACTIVE:\" -b toggle,fullscreen"
			\}

" Window state by default.
let s:winState = "normal"
" }

" FUNCTIONS =============================
function s:GetWinProp()
	" Returns the window's properties.
	" [guioptions, width, height, x, y]

	let [l:columns, l:lines] = [&columns, &lines]
	let [l:posX, l:posY] = [getwinposx(), getwinposy()]
	let l:guiOpt = has('gui_running') ? &guioptions : ""

	return [l:guiOpt, l:columns, l:lines, l:posX, l:posY]
endfunction
function s:VullScreen()
	" Main function.

	if executable('wmctrl')
		if s:winState == "normal"
			let s:winProp = s:GetWinProp()
			set guioptions-=m
			set guioptions-=T
			execute "!".s:FullScreenCmd.unix
			redraw!
			let s:winState = "fullscreen"
		else
			execute "!".s:FullScreenCmd.unix
			let &guioptions = s:winProp[0]
			let [&columns, &lines] = [s:winProp[1], s:winProp[2]]
			execute "winpos ".s:winProp[3]." ".s:winProp[4].""
			redraw!
			let s:winState = "normal"
		endif
	else
		echo "'wmctrl' is required, http://tomas.styblo.name/wmctrl/"
	endif
endfunction


let &cpoptions = s:saveCpoptions
unlet s:saveCpoptions
