#!/bin/bash
set -euf -o pipefail

#### =========================================== ####
## Configuration bootstrap for openSUSE tumbleweed ##
#### =========================================== ####

# wm, i3
deps+=" i3 i3blocks rofi pcmanfm alacritty feh fira-code-fonts fontawesome-fonts xfce4-notifyd libnotify-tools picom mediainfo bc ffmpeg playerctl"

# shell
deps+=" zsh"

# git
deps+=" git git-delta"

# dev
deps+=" gcc gcc-c++ clang neovim kakoune libopenssl-devel systemd-devel"

# audio
deps+=" pulseaudio"

# applications
deps+=" ripgrep keybase-client stow curl neovim fd fzf bat exa bottom lxappearance nnn seahorse file-roller calcurse mpv qalculate"

# password store
deps+=" password-store password-store-dmenu pinentry-gtk2"

# codecs
deps+=" opi"

# japanese
deps+=" adobe-sourcehansans-jp-fonts fcitx fcitx-mozc"

# Zypper install
echo "=========== Ignite! ============"
sudo zypper refresh
sudo zypper dist-upgrade
yes | sudo zypper install $deps

# Install codecs through `opi`
echo "======== Install codecs ========"
yes | opi codecs

# Basic dotfile setup
echo "===== Start basic_setup.sh ====="
./basic_setup.sh

