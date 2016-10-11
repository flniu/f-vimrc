# f-vimrc

A **Minimal & Universal** Vim runtime configuration.

This project is based on my personal vim configuration, so it includes my preferences. You can fork, change, and use it according to your needs.

## Table of Content

* [Goals & Principles](#goals--principles)
* [Installation](#installation)
* [Usage](#usage)
* [Plugin Management](#plugin-management)
* [Customization](#customization)
* [Misc](#misc)
* [License](#license)

## Goals & Principles

>Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.
>
>    -- Antoine de Saint-Exupery

I try to make it minimal and universal:

* Keep it simple: only add or change settings when necessary.
* Suitable for various environments: Mac/Linux/Windows, GUI/Console, Desktop/Server.
* Easy to setup and use, no special requirements. It works well without `+python` or `+python3` although these features are advised.
* Easy to understand and customize. The code is well-organized. It could be a good example for new vimers. (I hope so.)

It is suitable for vimers who work on different platforms and with different languages. However, it can also be customized easily according to special usage, such as Python development, Web development, etc.

## Installation

#### Desktop

###### Linux

Download or clone repo to `.vim` folder:

```sh
cd ~
git clone --depth=1 https://github.com/flniu/f-vimrc.git .vim
```

###### Windows

Download or clone repo to `vimfiles` folder:

```dosbatch
cd %USERPROFILE%
git clone --depth=1 https://github.com/flniu/f-vimrc.git vimfiles
```

If you have installed full repo, execute command `:PlugInstall` in Vim to install default plugins. All default plugins are listed in `vimrc.plugin`.

Vim earlier than 7.4 may not use the 2nd user vimrc file: "~/.vim/vimrc", in that case, you need to create a "~/.vimrc" links to "~/.vim/vimrc". Run `vim --version | grep vimrc` to check it. However, it is advised to use latest Vim on desktop environment.

#### Server

Use single `.vimrc` file on servers:

```sh
cd ~
curl -o .vimrc https://raw.githubusercontent.com/flniu/f-vimrc/master/vimrc
```

(Change to `_vimrc` on Windows server.)

## Usage

Code is the first document. You can find configurations, key-mappings, commands in the code. Although it can be used directly after installation, reading the code (with `:h` if necessary) to understand its meaning is more recommended.

If you have any question or advice, create an [issue][new-issue]. I'm glad to hear feedbacks.

## Plugin Management

There are 2 methods to manage plugins in this project:
* [pathogen][]:
  With this practical runtime-path manager, you can download or clone or create plugins in default `bundle` folder. It's easy to try some plugins without messing your runtime-path or changing your configuration file.
* [vim-plug][]:
  With this powerful and minimalist plugin manager, managing your must-have plugins will be simple and effective. Plugins managed by **vim-plug** will be put in default `plugged` folder.

My personal habit:
* Try new plugin with **pathogen**;
* If it is what I need and I want to make it under version control and portable, then copy the plugin folder from `bundle` to `plugged` and add it in **vim-plug** section. (I would not use `git submodule` because it's inconvenient in contrast to **vim-plug**.)

You can choose either of them and change the settings in `vimrc.plugin`.

Check **pathogen** and **vim-plug** pages for detailed introduction.

## Customization

If you want to add custom settings without changing original **f-vimrc** scripts:
* Create folder `custom`.
* Create files `custom/vimrc` & `custom/vimrc.plugin` and add your custom settings. These two files are sourced automatically.
* You can also create a git repo for your `custom` folder.

###### Example of custom/vimrc:

```vim
au BufNewFile,BufRead *.sgf set filetype=sgf
au BufNewFile,BufRead *.cue set filetype=cue et ts=2 sw=2
au BufNewFile,BufRead *.{cmd,bat} set et ts=2 sw=2
au BufWritePre,FileWritePre *.{cmd,bat,tab} if &bomb == 0 | set fenc=cp936 ff=dos | endif
```

###### Example of custom/vimrc.plugin:

```vim
" vim-plug
if exists('g:plugs')
  " Omit `call plug#begin()` because it has been called in vimrc.plugin
  " Color schemes
  Plug 'altercation/vim-colors-solarized'
  Plug 'tomasr/molokai'
  Plug 'blueshirts/darcula'
  " Syntax for Confluence wiki
  Plug 'flniu/confluencewiki.vim'
  call plug#end()
endif
" SnipMate
let g:snips_author = 'Francis Niu'
let g:snips_github = 'https://github.com/flniu'
```

## Misc

* Customize snippets in `snippets` folder.
* Create templates in `template` folder.
* Historical tip: "rc" suffix of dot files has a long history and has formed several different meanings; I choose "Vim runtime configuration" to stand for "vimrc". Read this post [What does "rc" mean in dot files](http://stackoverflow.com/questions/11030552/what-does-rc-mean-in-dot-files) if you have interest.

## License

MIT


[new-issue]:    https://github.com/flniu/f-vimrc/issues/new
[pathogen]:     https://github.com/tpope/vim-pathogen
[vim-plug]:     https://github.com/junegunn/vim-plug
