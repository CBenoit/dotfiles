# Dependencies and other details

## i3

- Launch `picom`, `volnoti`, `nm-applet`, `fcitx`, `xfce4-notifyd` and some desktop applications in `.local/wm/on_i3_startup` script.
- Screenshots are handled using `scrot`.
- `feh` is used to set the background.
- `rofi` is used as an application launcher (and other usages such as shutdown menu)
- `playerctl` is used to add media player control abilities.
- `parcellite` as clipboard manager.
- `pcmanfm` as file manager (don't forget `gvfs` for trash management)
- `polkit-gnome` and `gnome-keyring` for keyring.

## TODO: i3status-rust

https://github.com/greshake/i3status-rust

## i3blocks

- `perl`
- `mpstat` (from `sysstat` packet) for CPU usage
- `i2c-tools` for temperature
- `acpi` for battery level
- `pulseaudio` for volume
- `light` is used to manage screen light on laptop

Fonts: `ttf-fira-mono` and `ttf-font-awesome`

### openSUSE: refresh repos on startup with systemd

For i3blocks `updates` blocklet to work, repos need to be refreshed at some point.

Write the following to `/etc/systemd/system/zypper-refresh.service`

```
[Unit]
Description=Refresh zypper repos at startup
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=zypper refresh
RestartSec=7200

[Install]
WantedBy=multi-user.target
```

Then reload systemd by running `systemctl daemon-reload` and enable the new service with `systemctl enable zypper-refresh.service`

## rofi

From https://github.com/Lomadriel/dotfiles

## zsh

I'm using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh#basic-installation) to facilitate customization.
Please [install it](https://github.com/robbyrussell/oh-my-zsh#basic-installation) before using `stow`.
Follow [these instructions](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh) for `zsh-syntax-highlighting` plugin.

This config uses [`starship`](https://starship.rs/) cross-shell prompt.

For emojis support in starship prompt, follow [this guide](https://oorkan.medium.com/emojifying-your-linux-terminal-9a5c1e8f6b3c).
tl;dr: just download [Google Noto Color Emoji](https://www.google.com/get/noto/) and [EmojiOne Android](https://github.com/joypixels/emojione-assets/releases), drop them to `~/.local/share/fonts/` and run `fc-cache -v -f`. Terminal should be restarted.

## xinit

Dependencies:
    - `gnome-keyring`

# Notes

- To send notifications, there is `notify-send`.
- To see symbolic key name there is the program `xev` (`xorg-xev`).
- `stow` is a good software to manage dotfiles (`stow -t ~ -S FOLDER_NAME` to symlink content of FOLDER_NAME into home)

## Programs

- `rofi` - application launcher (and other usages such as shutdown menu)
- `playerctl` - add media player control abilities
- `pcmanfm` - as graphical filemanager
- `nnn` - (n³) as terminal filemanager
- `feh` - for background management
- `network-manager-applet` - for network connection (executable name: nm-applet)
- `lxappearance` - to configure GTK applications
- `xfce4-notifyd` - for notifications management (/usr/lib/xfce4/notifyd/xfce4-notifyd to run)
- `rofi` - as application launcher and focus switch (rofi -show run, to launch application)
- `pavucontrol` - to manage audio stuff.
- `seahorse` - to manage keyring.
- `file-roller` - as archive manager.
- `calcurse` - curse calendar
- `sxiv` - Simple X Image Viewer
- `foliate` - A simple and modern eBook viewer for Linux desktops

### Rust

- `ripgrep` - `grep` replacement
- `alacritty` - as terminal emulator
- `exa` - `ls` replacement
- `rg` - `grep` replacement
- `bat` - `cat` replacement (with synthax highlighting)
- `fd` - `find` replacement
- `hexyl` - as a cat-like colored hex viewer
- `xxv` - interactive hex viewer
- `zoxide` - A faster way to navigate your filesystem (similar to `autojump`)
- `zellij` - A terminal workspace with batteries included (replaces `tmux` and `screen`)
- `procs` - `ps` replacement
- `sd` - `sed` alternative with simpler syntax (`tr` on steroids)
- `dust` - A more intuitive version of `du` in rust
- `tokei` - Count your code, quickly
- `hyperfine` - A command-line benchmarking tool
- `bottom` - `top` alternative
- `tealdeer` - `tldr` implementation
- `bandwhich` - Terminal bandwidth utilization tool, display current network utilization by process, connection, remote IP, hostname…
- `grex` - A command-line tool and library for generating regular expressions from user-provided test cases 
- `nushell` - A new type of shell (pipeline-based, similar to PowerShell)
- `ddh` / `fclones` - Fast duplicate file finder
- `eva` - a calculator REPL, similar to bc(1)
- `delta` - A viewer for git and diff output
- `diskonaut` - Terminal disk space navigator
- `rusty-man` - Command-line viewer for rustdoc documentation
- `broot` - Get an overview of a directory, even a big one (better than `tree`)
- `gitui` - Blazing fast terminal-ui for git
- `git absorb` - git commit --fixup, but automatic
- `mdcat` - cat for markdown
- `shotgun` - Minimal X screenshot utility
- `terminal-typeracer` - An open source terminal based version of Typeracer written in rust.
- `oha` - HTTP load generator, inspired by rakyll/hey with tui animation.
- `kmon` - Linux Kernel Manager and Activity Monitor
- `battop` - Interactive batteries viewer
- `csview` - A high performance csv viewer with cjk/emoji support.
- `pipe-rename` - Rename your files using your favorite text editor
- `git-trim` - Automatically trims your branches whose tracking remote refs are merged or stray
- `cargo sweep` - A cargo subcommand for cleaning up unused build files generated by Cargo Resources
- `cargo wipe` - Cargo subcommand that recursively finds and optionally wipes all "target" or "node_modules" folders that are found in the current path.
- `lfs` - A thing to get information on your mounted disks

### To consider

- `xfce4-power-manager` (Power Management - very handy for a laptop)
- `pasystray` (full pulseaudio control from the system tray)
- `dotenv-linter` - checks .env files for problems that may cause the application to malfunction
- `neomutt` - NeoMutt is a command line mail reader (or MUA). It’s a fork of Mutt with added features. 
- `newsboat` - An RSS/Atom feed reader for text terminals 
- `sent` - Creates a presentation immediately from a plain text file https://tools.suckless.org/sent/
- `meli` - Experimental terminal mail client
- https://direnv.net/
- https://github.com/out-of-cheese-error/the-way
- https://github.com/ms-jpq/sad
- https://github.com/dmerejkowsky/ruplacer

## openSUSE: codecs quickstart

```bash
sudo zypper install opi && opi codecs
```

## Good japanese font

```
sudo zypper install adobe-sourcehansans-jp-fonts
```

# URLs

- https://blog.burntsushi.net/system76-darter-archlinux/
- https://suckless.org/rocks/
- https://github.com/mayfrost/guides/blob/master/ALTERNATIVES.md
