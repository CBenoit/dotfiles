#!/bin/bash
set -euf -o pipefail

## Set keymap

sudo localectl set-keymap fr-bepo_afnor

#### =========================================== ####
## Configuration bootstrap for openSUSE tumbleweed ##
#### =========================================== ####

# wm, i3
deps+=" i3 i3blocks rofi pcmanfm alacritty feh fira-code-fonts fontawesome-fonts xfce4-notifyd libnotify-tools picom mediainfo bc polkit-gnome xfce4-power-manager blueberry"

# shell
deps+=" zsh"

# git
deps+=" git git-delta"

# dev
deps+=" gcc gcc-c++ clang cmake neovim kakoune libopenssl-devel systemd-devel"

# multimedia
deps+=" pulseaudio pavucontrol mpv scrot ffmpeg playerctl"

# applications
deps+=" ripgrep keybase-client stow curl neovim fd fzf bat exa bottom lxappearance nnn seahorse file-roller calcurse qalculate parcellite sxiv foliate redshift-gtk"

# password store
deps+=" password-store password-store-dmenu pinentry-gtk2"

# codecs
deps+=" opi"

# japanese
deps+=" adobe-sourcehansans-jp-fonts fcitx fcitx-mozc fcitx-qt5 fcitx-gtk2 fcitx-gtk3"

# Zypper install
echo "=========== Ignite! ============"
sudo zypper refresh
sudo zypper dist-upgrade
yes | sudo zypper install $deps || true

# Install codecs through `opi`
echo "======== Install codecs ========"
yes | opi codecs || true

# Basic dotfile setup
echo "===== Start basic_setup.sh ====="
./basic_setup.sh

