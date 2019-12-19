# i3

- Launch `picom`, `volnoti`, `nm-applet`, `fctix`, `xfce4-notifyd` and some desktop applications in `.local/wm/on_i3_startup` script.
- Screenshots are handled using `scrot`.
- `feh` is used to set the background.
- `rofi` is used as an application launcher.
- `playerctl` is used to add media player control abilities.
- `light` (from AUR) is used to easily manage screen light.
- `libqalculate` (qalc) as calculator.
- `parcellite` as clipboard manager.
- `pcmanfm` as file manager.
- `polkit-gnome` and `gnome-keyring` for keyring.

# Notes

- To send notifications, there is `notify-send`.
- To see symbolic key name there is the program `xev` (`xorg-xev`).
- `stow` is a good software to manage dotfiles (`stow -t ~ -S FOLDER_NAME` to symlink content of FOLDER_NAME into home)

# replacement tools:

- `pcmanfm` - as filemanager
- `feh` - for background management
- `polybar` - for better status bar
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

# To consider
- `xfce4-power-manager` (Power Management - very handy for a laptop)
- `sxiv` (it's the vim of image viewers)
- `pasystray` (full pulseaudio control from the system tray)

# rofi

From https://github.com/Lomadriel/dotfiles

# termite

From https://github.com/Lomadriel/dotfiles

You might want `compton` for transparancy.

# polybar

From https://github.com/Lomadriel/dotfiles

Dependencies:
- `termite`
- `playerctl`
- `yay`
- `ranger`
- `calcurse`
- fonts:
    - `ttf-fira-mono`
    - `adobe-source-han-sans-jp-fonts`
    - `ttf-font-awesome`
    - `ttf-material-icons`

You might want `compton` for transparancy as well.

# zsh

I'm using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh#basic-installation) to facilitate customization.
Please [install it](https://github.com/robbyrussell/oh-my-zsh#basic-installation) before using stow.
Follow [these instructions](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh) for `zsh-syntax-highlighting` plugin.

# xinit

Dependencies:
    - `gnome-keyring`

