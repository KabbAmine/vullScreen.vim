# VullScreen, <small>Full-screen mode for Vim</small> [![GitHub version](https://badge.fury.io/gh/kabbamine%2Fvullscreen.vim.svg)](https://badge.fury.io/gh/kabbamine%2Fvullscreen.vim)

## Vull..what?

Nothing fancy here (Except the strange name), **vullScreen** is a small vim plugin that allows you to toggle Vim in full-screen mode on GNU/Linux.

I'm talking about a real full-screen mode, no menu and no toolbars as shown in the following gif.

![vullScreen in action](.img/vullScreen.gif)

## Installation

VullScreen requires [wmctrl](http://tomas.styblo.name/wmctrl/) (Present in the default repositories of most GNU/Linux distributions), so install it using your preferred packet manager.

Then, use your preferred method to install the plugin (I recommend using a plugin manager as [Vim-plug](https://github.com/junegunn/vim-plug), [Vundle](https://github.com/gmarik/Vundle.vim) or [NeoBundle](https://github.com/Shougo/neobundle.vim)...)

| Plugin manager   | In vimrc                               | Installation command   |
| ---------------- | -------------------------------------- | ---------------------- |
| `Vim-plug`       | `Plug 'KabbAmine/vullScreen.vim'`      | `PlugInstall`          |
| `Vundle`         | `Plugin 'KabbAmine/vullScreen.vim'`    | `PluginInstall`        |
| `NeoBundle`      | `NeoBundle 'KabbAmine/vullScreen.vim'` | `NeoBundleInstall`     |

## How to use?

With the command:

```
:VullScreen
```

Or using the key `<F11>` in both *NORMAL* and *INSERT* mode.

## Why F11?

Because its nice and common to a lot of programs, but if you want to change it to something else simply add to your `vimrc`:

```
let g:vullscreen_key = '<SOMETHING ELSE>'
```

## Notes

You don't really need this plugin if you're using Vim on a terminal (The full-screen option is included in most graphical terminals).

## Thanks

To wmctrl's author.

To Bram Moolenaar for creating the best piece of software in the world :heart:

To you if you're using vullScreen.
