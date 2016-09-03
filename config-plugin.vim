" Configuration for plugins
" Author: Francis Niu (https://github.com/flniu)
" Last Change: 2016-09-03 14:53:14

" pathogen {{{
if filereadable($VIMFILES . '/autoload/pathogen.vim')
  execute pathogen#infect()
endif
"}}}

" vim-plug {{{
if filereadable($VIMFILES . '/autoload/plug.vim')
  call plug#begin()

  " vim-snippets, depends on ultisnips or vim-snipmate
  if has('python') || has('python3')
    Plug 'SirVer/ultisnips'
  else
    Plug 'MarcWeber/vim-addon-mw-utils'
    Plug 'tomtom/tlib_vim'
    Plug 'garbas/vim-snipmate'
  endif
  Plug 'honza/vim-snippets'

  " NerdTree, on-demand loading
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  " Tagbar, on-demand loading
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

  " CtrlP, fuzzy file finder
  Plug 'kien/ctrlp.vim'

  " Emmet, toolkit for web-developers
  Plug 'mattn/emmet-vim'

  " Syntastic, syntax checking
  Plug 'scrooloose/syntastic'

  " fugitive, git wrapper
  Plug 'tpope/vim-fugitive'

  " surround, quoting/parenthesizing
  Plug 'tpope/vim-surround'

  " EasyMotion, move cursor more easily
  Plug 'easymotion/vim-easymotion'

  " Tabular, text alignment
  Plug 'godlygeek/tabular'

  call plug#end()
endif
"}}}

" Plugin variables & key-mappings {{{
" TOhtml
let g:html_ignore_folding = 1
let g:html_use_css = 1
let g:use_xhtml = 1
" SnipMate
let g:snips_author = 'Francis Niu (https://github.com/flniu)'
" NerdTree
nmap <F9> :NERDTreeToggle<CR>
" Tagbar
nmap <F10> :TagbarToggle<CR>
"}}}

" vim:et:ts=2:sw=2:fdm=marker:
