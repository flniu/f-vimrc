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

If you have any question or advice, create an [issue](https://github.com/flniu/f-vimrc/issues/new). I'm glad to hear feedbacks.

## Plugin Management

There are 3 methods to manage plugins in **f-vimrc**:
* Vim traditional method:
  Folders `colors`, `plugin`, `syntax` include several stable scripts and they are portable without Git or Internet access. I call them **build-in plugins**. Only slow-changing and necessary scripts will be added here.
* [pathogen](https://github.com/tpope/vim-pathogen):
  With this practical runtime-path manager, you can download or clone or create plugins in default `bundle` folder. It's easy to try some plugins without messing your runtime-path or changing your configuration file.
* [vim-plug](https://github.com/junegunn/vim-plug):
  With this powerful and minimalist plugin manager, managing your must-have plugins will be simple and effective. Plugins managed by **vim-plug** will be put in default `plugged` folder.

My personal habit is: Try new plugin with **pathogen**; If it is what I need, then copy the plugin folder from `bundle` to `plugged` and add it in **vim-plug** section.

You can choose either of them and change the settings in `config-plugin.vim`.

Check **pathogen** and **vim-plug** pages for detailed introduction.

## TODO/Not-tested

* Vim tiny version and small version. These may be the default vi version on some server systems.
* Vim on Mac.
* Neovim.

## Misc

* Customize snippets in `snippets` folder.
* Create templates in `template` folder.
* Historical tip: `rc` suffix of dot files has a long history and has formed several similar meanings; I choose "Vim runtime configuration" to stand for "vimrc". Read this post [What does "rc" mean in dot files](http://stackoverflow.com/questions/11030552/what-does-rc-mean-in-dot-files) if you have interest.

## License

MIT
