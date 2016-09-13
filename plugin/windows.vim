" MS-Windows configuration
" Author: Francis Niu
" Last Change: 2016-09-13

if exists('g:my_os') && g:my_os != 'Windows'
  finish
endif

if exists('did_windows_vim') || &cp || version < 700
  finish
endif
let did_windows_vim = 1

behave mswin

" Use <C-X><C-C><C-V> to cut/copy/paste {{{
vnoremap <C-X> "+x
vnoremap <C-C> "+y
map <C-V> "+gP
cmap <C-V> <C-R>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
noremap <C-Q> <C-V>
"}}}

" Use <C-S> to save {{{
nmap <C-S> :update<CR>
imap <C-S> <C-O>:update<CR>
"}}}

" Diff solution {{{
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
if &diff && has('gui_running')
  au GUIEnter * simalt ~x
endif
"}}}

" GUI settings {{{
if has('gui_running')
  set guioptions+=g
  " Use <F1> to toggle menu
  nmap <silent> <F1> :if &go =~# 'm' <Bar> set go-=m <Bar> else <Bar> set go+=m <Bar> endif<CR>
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
  set lines=40 columns=120
  nmap <C-\> :call ToggleFullScreen()<CR>
  function! ToggleFullScreen() "{{{
    if &lines == 40 && &columns == 120
      simalt ~x
    else
      set lines=40 columns=120
    endif
  endfunction "}}}
  nmap <C-Up> :call SetFontSize('+')<CR>
  nmap <C-Down> :call SetFontSize('-')<CR>
  nmap <C-CR> :call SetFontSize('0')<CR>
  function! SetFontSize(action) "{{{
    if a:action == '+'
      let g:my_fontsize += 1
    elseif a:action == '-'
      let g:my_fontsize -= 1
    else
      let g:my_fontsize = 10 " default font size
    endif
    let &gfn = 'Courier_New:h' . g:my_fontsize
    "let &gfw = 'SimHei:h' . g:my_fontsize
  endfunction "}}}
  call SetFontSize('0')
endif
"}}}

" vim:et:ts=2:sw=2:fdm=marker:
