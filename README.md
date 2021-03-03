# Dependencies and other details

## i3

- Launch `picom`, `volnoti`, `nm-applet`, `fctix`, `xfce4-notifyd` and some desktop applications in `.local/wm/on_i3_startup` script.
- Screenshots are handled using `scrot`.
- `feh` is used to set the background.
- `rofi` is used as an application launcher (and other usages such as shutdown menu)
- `albert`, if present, is used as the application launcher instead of `rofi`
- `playerctl` is used to add media player control abilities.

- `libqalculate` (qalc) as calculator.
- `parcellite` as clipboard manager.
- `pcmanfm` as file manager (don't forget `gvfs` for trash management)
- `polkit-gnome` and `gnome-keyring` for keyring.

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

For emojis support in starship prompt, follow [this guide](https://oorkan.medium.com/emojifying-your-linux-terminal-9a5c1e8f6b3c).
tl;dr: just download [Google Noto Color Emoji](https://www.google.com/get/noto/) and [EmojiOne Android](https://github.com/joypixels/emojione-assets/releases), drop them to `~/.local/share/fonts/` and run `fc-cache -v -f`. Terminal should be restarted.

## xinit

Dependencies:
    - `gnome-keyring`

# Notes

- To send notifications, there is `notify-send`.
- To see symbolic key name there is the program `xev` (`xorg-xev`).
- `stow` is a good software to manage dotfiles (`stow -t ~ -S FOLDER_NAME` to symlink content of FOLDER_NAME into home)

## Nice replacement tools:

- `pcmanfm` - as filemanager
- `feh` - for background management
- `network-manager-applet` - for network connection (executable name: nm-applet)
- `alacritty` - as terminal emulator
- `lxappearance` - to configure GTK applications
- `xfce4-notifyd` - for notifications management (/usr/lib/xfce4/notifyd/xfce4-notifyd to run)
- `rofi` - as application launcher and focus switch (rofi -show run, to launch application)
- `pavucontrol` - to manage audio stuff.
- `seahorse` - to manage keyring.
- `file-roller` - as archive manager.
- `exa` - `ls` replacement
- `rg` - `grep` replacement
- `bat` - `cat` replacement (with synthax highlighting)
- `fd` - `find` replacement
- `hexyl` - as a cat-like colored hex viewer
- `calcurse` as calendar
- `zoxide` - A faster way to navigate your filesystem (similar to `autojump`)

## To consider

- `xfce4-power-manager` (Power Management - very handy for a laptop)
- `pasystray` (full pulseaudio control from the system tray)
- `fclones` - Efficient Duplicate File Finder
- `csview` - A high performance csv viewer with cjk/emoji support.
- `pipe-rename` - Rename your files using your favorite text editor
- `hyperfine` - A command-line benchmarking tool
- `verco` - A simple Git/Hg tui client focused on keyboard shortcuts
- `oha` - HTTP load generator, inspired by rakyll/hey with tui animation.
- `git-trim` - Automatically trims your branches whose tracking remote refs are merged or stray
- `bandwhich` - Terminal bandwidth utilization tool
- `tealdeer` - A very fast implementation of tldr in Rust.
- `kmon` - Linux Kernel Manager and Activity Monitor
- `battop` - Interactive batteries viewer
- `xxv` - interactive hex viewer
- `cargo wipe` - Cargo subcommand that recursively finds and optionally wipes all "target" or "node_modules" folders that are found in the current path.
- `lfs` - A thing to get information on your mounted disks
- `dotenv-linter` - checks .env files for problems that may cause the application to malfunction
- `bottom` - Yet another cross-platform graphical process/system monitor.
- `terminal-typeracer` - An open source terminal based version of Typeracer written in rust.
- `ddh` - A fast duplicate file finder
- `dust` - A more intuitive version of du in rust
- `shotgun` - Minimal X screenshot utility
- `mdcat` - cat for markdown
- `git absorb` - git commit --fixup, but automatic
- `eva` - a calculator REPL, similar to bc(1)
- `delta` - A viewer for git and diff output
- `meli` - Experimental terminal mail client
- `dtool` - A command-line tool collection to assist development
- `diskonaut` - Terminal disk space navigator
- `rusty-man` - Command-line viewer for rustdoc documentation
- `broot` - Get an overview of a directory, even a big one (better than tree)
- `gitui` - Blazing fast terminal-ui for git
- `emulsion` - A lightweight and minimalistic image viewer

## openSUSE: codecs quickstart

```bash
sudo zypper install opi && opi codecs
```

