" Full-screen mode in GNU/Linux.
" Version: 0.6
" Creation     : 2014-09-16
" Modification : 2015-12-26
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
				\| call vullScreen#Toggle()
			\| else
				\| echoerr '"wmctrl" is required, please see http://tomas.styblo.name/wmctrl/'
			\| endif
" Mappings {{{1
let s:map = !exists('g:vullscreen_key') ? '<F11>' : g:vullscreen_key
execute 'nnoremap ' . s:map . ' :VullScreen<CR>'
execute 'inoremap ' . s:map . ' <C-o>:VullScreen<CR>'
unlet s:map
" 1}}}

" Restore default vim options {{{1
let &cpoptions = s:saveCpoptions
unlet s:saveCpoptions
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
