# CBenoit VIM config

![Preview screenshot](http://i.imgur.com/cy9khCJ.png)

I assume that you are under a Unix based system.
Don't hesitate to change anything to fit your needs.

+ [Installation](#installation)
    + [Dependencies](#dependencies)
+ [BÉPO friendly](#bÉpo-friendly)
+ [Plugins](#plugins)
    + [You might be interested in](#you-might-be-interested-in)
+ [About Ack](#about-ack)
+ [About auto-completion](#about-auto-completion)
+ [About snippets](#about-snippets)
+ [About multiples cursors](#about-multiples-cursors)
+ [About syntax checker : Syntastic](#about-syntax-checker--syntastic)
+ [About Eclim](#about-eclim)
+ [Better Java syntax highlighting](#better-java-syntax-highlighting)
+ [Considerations about Windows](#considerations-about-windows)
+ [Good resources to learn more about VIM editor](#good-resources-to-learn-more-about-vim-editor)
    + [Inspirations](#inspirations)

## Installation

Backup your `~/.vim` folder if you want to.

Get this config from github.
`$ git clone https://github.com/CBenoit/vim-config ~/.vim`
I noticed that creating a symbolic link to ~/.vim/vimrc isn't necessary.

Plugins managed using Vundle! You can easily install or remove plugins, and they are installed into ~/.vim/bundle/.
See https://github.com/gmarik/vundle for more information.
Everything will automatically be installed at vim first start with this config.
If you want to remove some plugins, do it before launching vim.
You should restart vim after plugins installation.
If gvim isn't appearing, try to run text based vim from terminal.

### Dependencies

You'll need vim 7.4+ compiled with python, ruby and lua support (if you use all plugins in my .vimrc file).
You can check with `vim --version | grep '+python'`, `vim --version | grep '+ruby'` and `vim --version | grep '+ruby'` or you can use vim command mode : `:echo has('python')`, `:echo has('ruby')` and `:echo has('lua')`.

## BÉPO friendly

This configuration works for BÉPO, QWERTY and AZERTY layouts.
You just have to tell whether you are using BÉPO or not by modifying [isbepo.vim](conf/isbepo.vim) file.
You should add `conf/isbepo.vim` to your `.gitignore` file.
If `isbepo` variable is set to `1`. Then, all keys are remaped to QWERTY while in NORMAL and VISUAL mode.

If you want my french cheatsheet for this config, see [bepo-french-vim-cheatsheet.md](bepo-french-vim-cheatsheet.md) file.

## Plugins

+ [Ack](https://github.com/mileszs/ack.vim) — Search for pattern in files.
+ [Airline](https://github.com/bling/vim-airline) — A beautiful status bar.
+ [ctrlp](https://github.com/kien/ctrlp.vim) — Search for files.
+ [Colorizer](https://github.com/lilydjwg/colorizer) — To colorize text in the form #rrggbb or #rgb.
+ [Cpp Enhanced Highlight](https://github.com/octol/vim-cpp-enhanced-highlight) — Better C++ highlight.
+ [EditorConfig](https://github.com/editorconfig/editorconfig-vim) — Help to define and maintain consistent coding styles.
+ [Fugitive](https://github.com/tpope/vim-fugitive) — An awesome Git wrapper.
+ [LustyExplorer & LustyJuggler](https://github.com/sjbach/lusty) — A fuzzy file and buffer explorer.
+ [Multiple cursors](https://github.com/kristijanhusak/vim-multiple-cursors) — Sublime Text-like multiple cursors feature.
+ [Markdown](https://github.com/plasticboy/vim-markdown) — Support for markdown.
+ [NeoComplete](https://github.com/Shougo/neocomplete.vim) — Handle completion.
+ [Syntastic](https://github.com/scrooloose/syntastic) — Syntax checking.
+ [Tabular](https://github.com/godlygeek/tabular) — To align regions of text.
+ [UltiSnips](https://github.com/sirver/ultisnips) — Excellent solution to handle snippets in VIM.
+ [vim2hs](https://github.com/dag/vim2hs) — A collection of vimscripts for Haskell development.

Colorscheme used :
[Monokai](https://github.com/crusoexia/vim-monokai)

### You might be interested in

+ [AutoClose](https://github.com/Townk/vim-autoclose) — Automatically close any character that could have a closing counterpart.
+ [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) — Handle autocompletion.

## About Ack

Ack.vim is a frontend for the Perl module [Ack](http://beyondgrep.com/).
You need Ack (>= 2.0) to use the plugin. To install follow the [manual](http://beyondgrep.com/install/).
You may have to change the `g:ackprg` variable in [conf/ack.vim](conf/ack.vim) file (for instance, under Debian, the name is `ack-grep` instead of `ack`).

## About auto-completion

My config uses [NeoComplete](https://github.com/Shougo/neocomplete.vim) plugin to handle autocompletion.

Some alternatives :
+ [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) — you'll need to build a third party program.
+ [supertab](https://github.com/ervandew/supertab)
+ [clang_complete](https://github.com/Rip-Rip/clang_complete)
+ [python-mode](https://github.com/klen/python-mode)
+ [jedi-vim](https://github.com/davidhalter/jedi-vim)
+ [AutoComplPop](https://github.com/vim-scripts/AutoComplPop)

They may fit your needs or not. Just make your choice and modify the .vimrc file.

## About snippets

This config uses SirVer's UltiSnips to handle snippets.
You can learn more about it with `:help UltiSnips` and by looking at its github page [UltiSnips' readme](https://github.com/sirver/ultisnips).
SirVer made some screencasts very useful to start using it.
Since YouCompleteMe/NeoComplete already use "Tab" key, I choose "c-j" (Ctrl + J) as UltiSnips' trigger key.
By the way, YouCompleteMe/NeoComplete provides a nice completion menu for UltiSnips.

My .vimrc file comes with tons of snippets from [honza repository](https://github.com/honza/vim-snippets).

## About multiples cursors

In order to go back to regular VIM, you cannot use an "esc" alias ("ii" in my case). You have to use the actual "esc" key.
See `:h multiple-cursors-mappings` for more information.

## About syntax checker : Syntastic

Syntastic does not know how to check syntax by itself.
So, you need to install external checkers corresponding to the types of files you use.
See [Syntastic wiki](https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers) for a fair list of syntax checkers.

To check Python syntax, I use [Pylint](https://github.com/scrooloose/syntastic/wiki/Python%3A---pylint).
Since I'm a Python 3 developer, I set a Python 3 interpreter in my [syntastic.vim](./conf/syntastic.vim) conf file.

## About Eclim

    Eclim provides the ability to access Eclipse code editing features
    (code completion, searching, code validation, and many more) via the
    command line or a local network connection, allowing those features
    to be integrated with your favorite editor. Eclim provides an integration
    with Vim, but third party clients have been created to add eclim support
    to other editors as well (emacs, sublime text 2, textmate).

See [Eclim website](http://eclim.org/index.html) to get it.

## Better Java syntax highlighting

You can find a better java syntax highlighting [here](https://github.com/sentientmachine/erics_vim_syntax_and_color_highlighting/).

## Considerations about Windows

This configuration may have some issues under Windows.
I haven't tested it under Windows yet, but here are some notes about how to port it.

+ [vimrc](./vimrc) — set proper paths for Vundle installation and others conf files at the end.
+ [ack.vim](./conf/ack.vim) — set a proper ack program : `let g:ackprg = "…"`
+ [syntastic.vim](./conf/syntastic.vim) — set a proper path to python interpreter : `let g:syntastic_python_python_exec = '…'`

## Good resources to learn more about VIM editor

+ http://bepo.fr/wiki/Vim : VIM and bépo disposition! [FRENCH]
+ http://vim-fr.org/ : french wiki about VIM. [FRENCH]
+ https://vimebook.com/ : book to start learning how to use VIM. [FRENCH]
+ http://www.vim.org/index.php : official website of course! [ENGLISH]
+ http://vim.wikia.com/ : wiki about VIM. [ENGLISH]
+ http://vim.wikia.com/wiki/Vim_Tips_Wiki : some tips. [ENGLISH]
+ http://vimcasts.org/ : various nice screencasts about VIM. [ENGLISH]

### Inspirations

+ [Fisa VIM config](https://github.com/fisadev/fisa-vim-config)
+ [Axiaoxin VIM config](https://github.com/axiaoxin/vim-settings)
+ [Auto installing Vundle](http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/)
+ [This blog post](http://nvie.com/posts/how-i-boosted-my-vim/)

