" Full-screen mode in GNU/Linux.
" version      : 0.6
" creation     : 2014-09-16
" modification : 2019-01-06
" maintainer   : Kabbaj Amine <amine.kabb@gmail.com>
" license      : This file is placed in the public domain.


" Vim options {{{1
if exists('g:vullscreen_loaded') || !has('unix')
    finish
endif
let g:vullscreen_loaded = 1

" To avoid conflict problems.
let s:saveCpoptions = &cpoptions
set cpoptions&vim
" 1}}}

fun! s:wmctrl_is_installed() abort " {{{1
    if !executable('wmctrl')
        echohl Error
        echon '[vullscreen] '
        echohl None
        echon '"wmctrl" is required (http://tomas.styblo.name/wmctrl/)'
        return v:false
    else
        return v:true
    endif
endfun
" 1}}}

" Main command {{{1
command! VullScreen if s:wmctrl_is_installed()
            \|  call vullScreen#toggle()
            \| endif
" 1}}}

" Mappings {{{1
let g:vullscreen_key = get(g:, 'vullscreen_key', '<F11>')
silent execute 'nnoremap ' . g:vullscreen_key . ' :VullScreen<CR>'
silent execute 'inoremap ' . g:vullscreen_key . ' <C-o>:VullScreen<CR>'
" 1}}}

" Restore default vim options {{{1
let &cpoptions = s:saveCpoptions
unlet s:saveCpoptions
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
