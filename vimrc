" My vimrc for Mac/Linux/Windows * GUI/Console
" Author: Francis Niu
" Last Change: 2016-08-31 23:19:13

" Global variables {{{
if has('win32') || has('win64')
  let g:my_os = 'Windows'
  let g:my_vimfiles = $HOME . '\vimfiles'
else
  let g:my_os = 'Linux'
  let g:my_vimfiles = $HOME . '/.vim'
endif
let $VIMFILES = g:my_vimfiles
let $TEMPLATE = g:my_vimfiles . '/template'
"}}}

" General settings {{{
set nocompatible
map Q :qa<CR>
if filereadable($VIMFILES . '/autoload/pathogen.vim')
  execute pathogen#infect()
endif
filetype plugin indent on
syntax on
if has('mouse')
  set mouse=a
endif

" Language
if g:my_os == 'Windows'
  language C
else
  language en_US.UTF-8
endif

" Basic editing
set history=100
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set incsearch
set hlsearch
set ignorecase
set virtualedit=block
set showcmd
set showmatch
set wildmenu
"set autochdir

" Layout & indent
set nowrap
set textwidth=0
set autoindent
set smartindent
set cindent
set shiftround
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Display
set shortmess=atI
set number
set statusline=%f\ %m%r[%{strftime('%Y%m%d',getftime(expand('%')))}]%=%{GetFileEditSetting()}\ %-21(%11(%l/%L%),%-3v\ %P%)
function! GetFileEditSetting() "{{{
  let misc = (&ar ? 'ar' : '')
  let fencstr = (&fenc == '' ? &enc : &fenc) . (&bomb ? '.BOM' : '')
  let ftstr = (&ft == '' ? '-' : &ft)
  let textmode = (&et ? '-' : '|') . &ts .
        \ (&cin ? 'c' : (&si ? 's' : (&ai ? 'a' : 'n'))) . &sw .
        \ (&wrap ? 'z' : '-') . &tw .
        \ (&ic ? (&scs ? 'S' : 'I') : 'C')
  return misc . '[' . fencstr . ',' . strpart(&ff,0,1) . '][' . ftstr . ',' . textmode . ']'
endfunction "}}}
set laststatus=2
set lazyredraw
set list
set listchars=tab:\|\ ,trail:-,nbsp:_
set scrolloff=5
if has('folding')
  set foldcolumn=2
endif

" File
set noswapfile
set nobackup
"set nowritebackup
"set autoread
set autowrite
if has('persistent_undo')
  set undodir=$TEMP,.
  set undofile
endif

" Encoding & multi-byte support
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1
set ambiwidth=double
set formatoptions+=mM

" Compatibility
if v:version >= 703
  set cryptmethod=blowfish
  nmap <Leader>rn :setl rnu!<CR>
endif
"}}}

" GUI & term {{{
if has('gui_running')
  colorscheme desert
  set guioptions=ceg
  nmap <silent> <F5> :if &go =~# 'm' <Bar> set go-=m <Bar> else <Bar> set go+=m <Bar> endif<CR>
  nmap <silent> <F6> :if &go =~# 'l' <Bar> set go-=l <Bar> else <Bar> set go+=l <Bar> endif<CR>
  nmap <silent> <F7> :if &go =~# 'b' <Bar> set go-=b <Bar> else <Bar> set go+=b <Bar> endif<CR>
  nmap <silent> <F8> :if &go =~# 'r' <Bar> set go-=r <Bar> else <Bar> set go+=r <Bar> endif<CR>
  source $VIMRUNTIME\delmenu.vim
  source $VIMRUNTIME\menu.vim
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
  nmap <C-0> :call SetFontSize('0')<CR>
  function! SetFontSize(action) "{{{
    if a:action == '+'
      let w:my_fontsize += 1
    elseif a:action == '-'
      let w:my_fontsize -= 1
    else
      let w:my_fontsize = 10 " default font size
    endif
    let fontstr = 'Courier_New:h' . w:my_fontsize
    exec 'set gfn=' . fontstr
    "let widefontstr = 'SimHei:h' . w:my_fontsize
    "exec 'set gfw=' . widefontstr
  endfunction "}}}
  call SetFontSize('0')
elseif &term == 'xterm'
  colorscheme desert256
  set t_Co=256
endif
"}}}

" Key-mappings {{{
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
nmap <ESC><ESC> :noh<CR>
nmap <A-Up> [c
nmap <A-Down> ]c
nmap <A-Left> zH
nmap <A-Right> zL
nmap <C-Tab> gt
nmap <C-S-Tab> gT
nmap <F2> :bp<CR>
nmap <F3> :bn<CR>
nmap <F4> :ls<CR>
nmap <F11> :let &ft = (&ft == 'txt' ? 'markdown' : 'txt')<CR>
nmap <F12> :setl wrap!<CR>
nmap <Leader>dt :diffthis<CR>
nmap <Leader>du :diffupdate<CR>
nmap <Leader>tn :tabnew<CR>
nmap <Leader>ar :set autoread!<CR>
nmap <Leader>et :setl et!<CR>
nmap <Leader>li :setl list!<CR>
nmap <Leader>sp :setl spell!<CR>
" Toggle cursor cross(column+line)
nmap <Leader>cr :setl cuc! cul!<CR>
nmap <Leader>tw :let &tw = (&tw > 0 ? 0 : 78)<CR>
nmap <Leader>xxd :call XxdToggle()<CR>
function! XxdToggle() "{{{
  let mod = &mod
  if getline(1) =~ "^0000000:"
    exe '%!xxd -r'
    set ft=
    doautocmd filetypedetect BufReadPost
  else
    exe '%!xxd'
    set ft=xxd
  endif
  let &mod = mod
endfunction "}}}
" Trim text: replace full-width space, remove trailing spaces, remove blank lines
nmap <Leader>tt :%s/\%u3000/ /ge <Bar> %s/\s\+$//e <Bar> g/^$/d<CR>
nmap <Leader>ac :%s/^.\+$/\0,/e<CR>
nmap <Leader>qc :%s/^.\+$/'\0',/e<CR>
nmap <Leader>eu :setl fenc=utf-8<CR>
nmap <Leader>eg :setl fenc=cp936<CR>
nmap <Leader>el :setl fenc=latin1<CR>
nmap <Leader>bm :setl bomb!<CR>
nmap <Leader>fd :setl ff=dos<CR>
nmap <Leader>fu :setl ff=unix<CR>
" Search visual selected text
vmap <silent> // y/<C-R>=substitute(escape(@",'\\/.*^$~[]'),'\n','\\n','g')<CR><CR>
"}}}

" Commands {{{
command! EVIMRC e $MYVIMRC
command! SOVIMRC so $MYVIMRC
" cd current path
command! CDC cd %:p:h
command! -nargs=? FT setl ft=<args>
command! -nargs=1 TS setl ts=<args> sw=<args>
command! -nargs=1 TSI setl ts=<args> sw=<args> fdm=indent
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1
command! -range=% Count <line1>,<line2>sort | <line1>,<line2>s#\(^.\+$\)\(\n^\1$\)*#\=submatch(1)."\t".((len(submatch(0))+1)/(len(submatch(1))+1))#
command! -nargs=? WT call WriteTempFile(<f-args>)
function! WriteTempFile(...) "{{{
  if expand('%') == ''
    let filename = strftime("%Y%m%d%H%M%S") . '.' . (a:0 >= 1 ? a:1 : 'tmp')
    exe 'write $TMP/' . filename
  endif
endfunction "}}}
command! -range=% FormatJSON <line1>,<line2>!python -m json.tool
"}}}

" Autocmds {{{
" last-position-jump
au BufReadPost *.txt if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" filetype settings
au BufNewFile,BufRead *.txt setl filetype=txt wrap fdm=marker cms=
au BufNewFile,BufRead *.py2,*.pyw2 setl filetype=python
au BufNewFile,BufRead *.cue setl filetype=cue et ts=2 sw=2
au BufNewFile,BufRead *.cmd,*.sh,*.vim setl et ts=2 sw=2
au BufNewFile,BufRead *.dtsConfig,*.rdl setl et ts=2 sw=2
au BufNewFile,BufRead *.xml,*web.config setl noet
au BufNewFile,BufRead *.ctl setl filetype=conf
au BufNewFile,BufRead *.cwiki setl filetype=confluencewiki
au BufNewFile,BufRead *.sgf setl filetype=sgf
au BufNewFile,BufRead *.md setl filetype=markdown
au FileType vim,perl,sh,cs setl noic
au FileType python setl noic cc=80,100 fdm=indent
au FileType sql setl noet nosi ar
au FileType yaml setl et ts=2 sw=2
au BufNewFile,BufRead *.json setl et ts=2 sw=2
au BufWritePre,FileWritePre *.cmd,*.bat,*.sql,*.tab if &bomb == 0 | setl fenc=cp936 ff=dos | endif
" timestamp
au BufWritePre,FileWritePre *vimrc,*.vim,*.ahk call SetTimeStamp()
function! SetTimeStamp() "{{{
  if line('$') > 10
    1,10s/Last Change:\s.*$/\=strftime("Last Change: %Y-%m-%d %H:%M:%S")/ge
  else
    %s/Last Change:\s.*$/\=strftime("Last Change: %Y-%m-%d %H:%M:%S")/ge
  endif
endfunction "}}}
"}}}

" vim:et:ts=2:sw=2:fdm=marker:
