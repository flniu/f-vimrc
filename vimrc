" My vimrc for Mac/Linux/Windows * GUI/Console * Vim/Neovim
" Author: Francis Niu (https://github.com/flniu)
" Last Change: 2020-07-18

" Global variables {{{
let is_nvim = has('nvim')
if is_nvim
  let $MYVIMRC = '~/.config/nvim/init.vim'
  let $VIMFILES = '~/.config/nvim'
else
  if has('win32') || has('win64')
    let g:my_os = 'Windows'
    let g:my_font = 'Consolas:h%d'
    let g:my_fontsize_default = 11
    let g:my_window_size = { 'S': [32, 108], 'L': [50, 160] }
    let $VIMFILES = $HOME . '\vimfiles'
  else
    if has('mac')
      let g:my_os = 'Mac'
      let g:my_font = 'Monaco:h%d'
      let g:my_fontsize_default = 12
      let g:my_window_size = { 'S': [40, 120], 'L': [60, 180] }
    else
      let g:my_os = 'Linux'
      let g:my_font = 'DejaVu Sans Mono %d'
      let g:my_fontsize_default = 10
      let g:my_window_size = { 'S': [40, 120], 'L': [50, 160] }
    endif
    let $VIMFILES = $HOME . '/.vim'
  endif
endif
if !exists($TMP)
  let $TMP = '~/.tmp'
endif
let $MYVIMRC_PLUGIN = $VIMFILES . '/vimrc.plugin'
"}}}

" General settings {{{
set nocompatible
try
  source $MYVIMRC_PLUGIN
endtry
filetype plugin indent on
syntax on
if has('mouse')
  set mouse=a
endif
set visualbell
" Use Q to quit and disable Ex-mode
map Q :q<CR>
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
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set nrformats-=octal
set iskeyword+=-
"}}}

" Layout & indent {{{
set nowrap
set textwidth=0
set autoindent
set cindent
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
  set foldcolumn=1
endif
"}}}

" File {{{
if !is_nvim
  set fileformats=unix,dos
  set noswapfile
  set nobackup
  "set nowritebackup
  "set autoread
  set autowrite
  set viminfofile=$VIMFILES/.viminfo
  if has('persistent_undo')
    let $VIMUNDODIR = $VIMFILES . '/.undodir'
    if !isdirectory($VIMUNDODIR) && exists('*mkdir')
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
endif
"}}}

" Encoding & multi-byte support {{{
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1
set ambiwidth=double
set formatoptions+=mM
"}}}

" GUI & Terminal {{{
if !is_nvim
  if has('gui_running')
    set guioptions=ce
    " Font & Window size {{{
    function! SetFontSize(action) "{{{
      if a:action == '+'
        let g:my_fontsize += 1
      elseif a:action == '-'
        let g:my_fontsize -= 1
      else
        let g:my_fontsize = g:my_fontsize_default
      endif
      let &gfn = printf(g:my_font, g:my_fontsize)
    endfunction "}}}
    call SetFontSize('0')
    function! SetWindowSize(level) "{{{
      if g:my_os == 'Windows' && a:level == 'L'
        simalt ~x
      else
        let &lines = g:my_window_size[a:level][0]
        let &columns = g:my_window_size[a:level][1]
      endif
    endfunction "}}}
    call SetWindowSize('L')
    nmap <C-CR> :call SetFontSize('0')<CR>
    nmap <C-Up> :call SetFontSize('+')<CR>
    nmap <C-Down> :call SetFontSize('-')<CR>
    nmap <C-Left> :call SetWindowSize('S')<CR>
    nmap <C-Right> :call SetWindowSize('L')<CR>
    "}}}
  else
    set t_Co=256
  endif
endif
if &term != 'win32'
  try
    colors molokai
  catch
    colors desert
  endtry
endif
"}}}

" Key-mappings {{{
" Make j/k behave like gj/gk but 1j/1k behave as normal
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
" Yank from cursor to end of line
noremap gy y$
noremap gc "*y$
" Double ESC to stop highlighting
nmap <ESC><ESC> :noh<CR>
" Jump diffs
nmap <S-F7> [c
nmap <F7> ]c
" Scroll screen left/right
nmap <A-Left> zH
nmap <A-Right> zL
" Increase/Decrease indent
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv
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
nmap <Leader>hn :new<CR>
nmap <Leader>vn :vnew<CR>
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
  if getline(1) =~ "^000000"
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
" Search conflicts
nmap <Leader>cf /<<<<\+\\|====\+\\|>>>>\+<CR>
" Save with sudo
cmap w!! w !sudo tee >/dev/null %
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
  let old_filename = expand('%')
  let new_filename = $TMP . '/' . strftime("%Y%m%d%H%M%S") . '.' . (a:0 >= 1 ? a:1 : 'tmp')
  if empty(old_filename)
    exe 'write ' . new_filename
  else
    exe '!mv ' . old_filename . ' ' . new_filename
    exe 'edit ' . new_filename
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
" filetype config
au FileType css,scss,javascript set foldmethod=marker foldmarker={,}
au FileType snippets set noet ts=4 sw=4 fdm=indent noml
au FileType yaml set et ts=2 sw=2
au FileType toml set et ts=2 sw=2
au FileType markdown set wrap foldlevel=1
au BufNewFile,BufRead *.sgf set filetype=sgf
au BufNewFile,BufRead *.cue set filetype=cue et ts=2 sw=2
au BufNewFile,BufRead *.{cmd,bat} set et ts=2 sw=2
au BufWritePre,FileWritePre *.{cmd,bat} if &bomb == 0 | set fenc=cp936 ff=dos | endif
"}}}

" Platform settings {{{
if !is_nvim
  if g:my_os == 'Windows'
    if filereadable($VIMFILES . '/vimrc.windows')
      source $VIMFILES/vimrc.windows
    endif
  elseif g:my_os == 'Mac'
    if filereadable($VIMFILES . '/vimrc.mac')
      source $VIMFILES/vimrc.mac
    endif
  else
    if filereadable($VIMFILES . '/vimrc.linux')
      source $VIMFILES/vimrc.linux
    endif
  endif
endif
"}}}

" vim:et:ts=2:sw=2:fdm=marker:
