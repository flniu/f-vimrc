" My vimrc for Mac/Linux/Windows * GUI/Console
" Author: Francis Niu (https://github.com/flniu)
" Last Change: 2016-09-17

" Global variables {{{
if has('win32') || has('win64')
  let g:my_os = 'Windows'
  let $VIMFILES = $HOME . '\vimfiles'
else
  let g:my_os = 'Linux'
  let $VIMFILES = $HOME . '/.vim'
endif
let $TEMPLATE = $VIMFILES . '/template'
"}}}

" General settings {{{
set nocompatible
if filereadable($VIMFILES . '/vimrc.plugin')
  source $VIMFILES/vimrc.plugin
endif
filetype plugin indent on
syntax on
if has('mouse')
  set mouse=a
endif
" Use Q to quit and disable Ex-mode
map Q :qa<CR>
"}}}

" Basic editing {{{
set history=1000
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set incsearch
set hlsearch
set ignorecase
set virtualedit=block
set showcmd
set showmatch
set wildmenu
set nrformats-=octal
"}}}

" Layout & indent {{{
set nowrap
set textwidth=0
set autoindent
set smartindent
set shiftround
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
"}}}

" Display {{{
set shortmess=atI
set number
set statusline=%f\ %m%r[%{strftime('%Y%m%d',getftime(expand('%')))}]%=%{GetFileEditSetting()}\ %9(%l/%L%),%-3v\ %P
function! GetFileEditSetting() "{{{
  let misc = (&ar ? 'ar,' : '') . (&paste ? 'p,' : '')
  let fencstr = (empty(&fenc) ? &enc : &fenc) . (&bomb ? '.BOM' : '')
  let textmode = (&et ? '-' : '|') . &ts . (&sts ? '.' . &sts : '') .
        \ (!empty(&inde) ? 'e' : &cin ? 'c' : &si ? 's' : &ai ? 'a' : 'n') . &sw .
        \ (&wrap ? 'z' : '-') . &tw .
        \ (&ic ? (&scs ? 'S' : 'I') : 'C')
  return misc . '[' . fencstr . ',' . strpart(&ff,0,1) . '][' . &ft . ',' . textmode . ']'
endfunction "}}}
set laststatus=2
set lazyredraw
set list
set listchars=tab:\|\ ,trail:-,nbsp:_,precedes:<,extends:>
set scrolloff=5
if has('folding')
  set foldcolumn=2
endif
"}}}

" File {{{
set noswapfile
set nobackup
"set nowritebackup
"set autoread
set autowrite
set viminfo+=n$VIMFILES/.viminfo
if has('persistent_undo')
  let $VIMUNDODIR = $VIMFILES . '/.undodir'
  if exists('*mkdir') && !isdirectory($VIMUNDODIR)
    call mkdir($VIMUNDODIR, 'p', 0700)
  endif
  set undodir=$VIMUNDODIR,$TMP,.
  set undofile
endif
if v:version >= 800
  set cryptmethod=blowfish2
elseif v:version >= 703
  set cryptmethod=blowfish
endif
"}}}

" Encoding & multi-byte support {{{
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1
set ambiwidth=double
set formatoptions+=mM
"}}}

" GUI & Terminal {{{
if has('gui_running')
  colorscheme desert
  set guioptions=ce
else
  if filereadable($VIMFILES . '/colors/desert256.vim')
    colorscheme desert256
  endif
  set t_Co=256
endif
"}}}

" Key-mappings {{{
" Make j/k behave like gj/gk but 1j/1k behave as normal
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
" Yank from cursor to end of line
noremap gY y$
" Double ESC to stop highlighting
nmap <ESC><ESC> :noh<CR>
" Jump diffs
nmap <A-Up> [c
nmap <A-Down> ]c
" Scroll screen left/right
nmap <A-Left> zH
nmap <A-Right> zL
" Jump tabs
nmap <C-Tab> gt
nmap <C-S-Tab> gT
" Jump or List buffers
nmap <F2> :bp<CR>
nmap <F3> :bn<CR>
nmap <F4> :ls<CR>
" Horizontal & Vertical split
nmap <Leader>hs :split<CR>
nmap <Leader>vs :vsplit<CR>
" Shortcut keys, press K on each command/option to find its meaning
" if K cannot locate an option, use :h 'option' instead
nmap <Leader>dt :diffthis<CR>
nmap <Leader>du :diffupdate<CR>
nmap <Leader>tn :tabnew<CR>
nmap <Leader>ar :set autoread!<CR>
nmap <Leader>pa :set paste!<CR>
nmap <Leader>et :set expandtab!<CR>
nmap <Leader>li :set list!<CR>
nmap <Leader>sp :set spell!<CR>
" Toggle line number & relative line number
nmap <Leader>nu :set nu!<CR>
nmap <Leader>rn :set rnu!<CR>
" Toggle cursor cross(column+line)
nmap <Leader>cr :set cuc! cul!<CR>
" Toggle textwidth & wrap
nmap <Leader>tw :let &tw = (&tw > 0 ? 0 : 78)<CR>
nmap <Leader>wr :set wrap!<CR>
" Toggle hex-editing
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
" Add comma, Add quotation and comma
nmap <Leader>ac :%s/^.\+$/\0,/e<CR>
nmap <Leader>qc :%s/^.\+$/'\0',/e<CR>
vmap <Leader>ac :s/^.\+$/\0,/e<CR>
vmap <Leader>qc :s/^.\+$/'\0',/e<CR>
" Change fileencoding, Toggle BOM
nmap <Leader>eu :set fenc=utf-8<CR>
nmap <Leader>eg :set fenc=cp936<CR>
nmap <Leader>el :set fenc=latin1<CR>
nmap <Leader>bm :set bomb!<CR>
" Change fileformat
nmap <Leader>fd :set ff=dos<CR>
nmap <Leader>fu :set ff=unix<CR>
nmap <Leader>fm :set ff=mac<CR>
" Search visual selected text
vmap <silent> // y/<C-R>=substitute(escape(@",'\\/.*^$~[]'),'\n','\\n','g')<CR><CR>
" Insert content of default register
imap <Insert> <C-R>"
cmap <Insert> <C-R>"
"}}}

" Commands {{{
" Edit/Source vimrc
command! EVIMRC e $MYVIMRC
command! SOVIMRC so $MYVIMRC
" cd current path
command! CDC cd %:p:h
" Shortcut commands
command! -nargs=? FT set ft=<args>
command! -nargs=1 TS set ts=<args> sw=<args>
command! -nargs=1 TSI set ts=<args> sw=<args> fdm=indent
" Reverse lines in range
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1
" Group-by lines and count
command! -range=% Count <line1>,<line2>sort | <line1>,<line2>s#\(^.\+$\)\(\n^\1$\)*#\=submatch(1)."\t".((len(submatch(0))+1)/(len(submatch(1))+1))#
" Write temp file, optional file extension name
command! -nargs=? WT call WriteTempFile(<f-args>)
function! WriteTempFile(...) "{{{
  if empty(expand('%'))
    let filename = strftime("%Y%m%d%H%M%S") . '.' . (a:0 >= 1 ? a:1 : 'tmp')
    exe 'write $TMP/' . filename
  endif
endfunction "}}}
command! -range=% FormatJSON <line1>,<line2>!python -m json.tool
"}}}

" Autocmds {{{
" last-position-jump
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" timestamp
au BufWritePre,FileWritePre * call SetTimeStamp()
function! SetTimeStamp() "{{{
  if line('$') > 10
    1,10s/Last Change:\s.*$/\=strftime("Last Change: %Y-%m-%d")/e
  else
    %s/Last Change:\s.*$/\=strftime("Last Change: %Y-%m-%d")/e
  endif
endfunction "}}}
" filetype settings
au BufNewFile *.vim set ff=unix
au FileType snippets set noet ts=4 sw=4 fdm=indent noml
au FileType yaml set et ts=2 sw=2
au FileType markdown set wrap foldlevel=1
"}}}

" Platform settings {{{
if g:my_os == 'Windows' && filereadable($VIMFILES . '/vimrc.windows')
  source $VIMFILES/vimrc.windows
endif
"}}}

" Custom settings {{{
if filereadable($VIMFILES . '/custom/vimrc')
  source $VIMFILES/custom/vimrc
endif
"}}}

" vim:et:ts=2:sw=2:fdm=marker:
