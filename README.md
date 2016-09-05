# f-vimrc

A **Minimal & Universal** Vim runtime configuration.

This project is based on my personal vim configuration, so it includes my preferences. You can fork, change, and use it according to your needs.

## Goals & Principles

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

If you have installed full repo, execute command `:PlugInstall` in Vim to install default plugins.

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

There are 3 methods to manage plugins in this project:
* Vim traditional method:
  Folders `autoload`, `colors`, `plugin` include several stable scripts and they are portable without Git or Internet access. I call them **build-in plugins**. Only core scripts will be added here.
* [pathogen][]:
  With this practical runtime-path manager, you can download or clone or create plugins in default `bundle` folder. It's easy to try some plugins without messing your runtime-path or changing your configuration file.
* [vim-plug][]:
  With this powerful and minimalist plugin manager, managing your must-have plugins will be simple and effective. Plugins managed by **vim-plug** will be put in default `plugged` folder.

My personal habit:
* Try new plugin with **pathogen**;
* If it is what I need and I want to make it under version control and portable, then copy the plugin folder from `bundle` to `plugged` and add it in **vim-plug** section. (I would not use `git submodule` because it's inconvenient in contrast to **vim-plug**.)

You can choose either of them and change the settings in `vimrc.plugin`.

Check **pathogen** and **vim-plug** pages for detailed introduction.

## TODO/Not-tested

* Vim tiny version and small version. These may be the default vi version on some server systems.
* Vim on Mac.
* Neovim.

## Misc

* Customize snippets in `snippets` folder.
* Create templates in `template` folder.
* Historical tip: `rc` suffix of dot files has a long history and has formed several different meanings; I choose "Vim runtime configuration" to stand for "vimrc". Read this post [What does "rc" mean in dot files](http://stackoverflow.com/questions/11030552/what-does-rc-mean-in-dot-files) if you have interest.

## Design Discussion

In following discussion, I use `$VIMFILES` to stand for the first `'runtimepath'`(see `:h vimfiles`). This variable is defined in `vimrc`.

#### The vimrc file

I use `$VIMFILES/vimrc` instead of general `$HOME/.vimrc`.
* Pro: It becomes easier to organize vimrc file with vimfiles together.
* Con: I cannot redefine the `'runtimepath'` to use the same `$HOME/.vim` directory on different platform (MS-Windows, etc).

#### Third-party scripts

I don't want to include external `git` or `curl` commands in vimrc. So I include several third-party scripts in this project.
* Pro: This repo can be copied to computers which may not have git/curl or Internet access.
* Con: It's not a clean and minimal design.

Third-party scripts list:
* `autoload/pathogen.vim`
* `autoload/plug.vim`
* `colors/desert256.vim`

You can use following commands to get or update these scripts:

```sh
curl -Lo autoload/pathogen.vim https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim
curl -Lo autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -Lo colors/desert256.vim https://github.com/vim-scripts/desert256.vim/raw/master/colors/desert256.vim
```

You can add comments or create an [issue][new-issue] to join discussion.

## License

MIT
(Except [third-party scripts](#third-party-scripts) which are under their own licenses.)


[new-issue]:    https://github.com/flniu/f-vimrc/issues/new
[pathogen]:     https://github.com/tpope/vim-pathogen
[vim-plug]:     https://github.com/junegunn/vim-plug
