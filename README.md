# i3

Launch `compton`, `volnoti`, `nm-applet`, `fctix`, `xfce4-notifyd`, `thunderbird`, `telegram-desktop`as well as `polybar` in `.local/wm/on_i3_startup` script.
Screenshots are handled using `scrot`.
`feh` is used to set the background.
`rofi` is used as an application launcher.
`playerctl` is used to add media player control abilities.
`light` (from AUR) is used to easily manage screen light.
`libqalculate` (qalc) as calculator.
`parcellite` as clipboard manager.
`thunar` as file manager.
`polkit-gnome` and `gnome-keyring` for keyring.

## Notes

- To send notifications, there is `notify-send`.
- To see symbolic key name there is the program `xev` (`xorg-xev`).
- `stow` is a good software to manage dotfiles.

### replacement tools:

- `feh` - for background management
- `polybar` - for better status bar
- `network-manager-applet` - for network connection (executable name: nm-applet)
- `termite` - as terminal emulator
- `lxappearance` - to configure GTK applications
- `xfce4-notifyd` - for notifications management (/usr/lib/xfce4/notifyd/xfce4-notifyd to run)
- `rofi` - as application launcher and focus switch (rofi -show run, to launch application)
- `pavucontrol` - to manage audio stuff.
- `seahorse` - to manage keyring.
- `file-roller` - as archive manager.
- not used:
    - `sxhkd` - for better keybinding management (/!\ had some issues with i3 lately. Need to be checked)

## TODO:
- `xfce4-power-manager` (Power Management - very handy for a laptop)
- `sxiv` (it's the vim of image viewers)
- `pasystray` (full pulseaudio control from the system tray)
- `pcmanfm` ? (filemanager)

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
- `trizen`
- `ranger`
- `calcurse`
- fonts:
    - `ttf-fira-mono`
    - `adobe-source-han-sans-jp-fonts`
    - `ttf-font-awesome`
    - `ttf-material-icons`

You might want `compton` for transparancy as well.

# xinit

Dependencies:
    - `gnome-keyring`

