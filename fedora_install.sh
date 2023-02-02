#!/bin/bash
set -euf -o pipefail

## Set keymap

sudo localectl set-keymap fr-bepo_afnor

#### =========================================== ####
## Configuration bootstrap for openSUSE tumbleweed ##
#### =========================================== ####

# RPM Fusion
echo "========= RPM Fusion ==========="
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# wm, i3
deps+=" i3 i3blocks rofi pcmanfm alacritty feh fira-code-fonts fontawesome-fonts xfce4-notifyd libnotify picom mediainfo bc polkit-gnome xfce4-power-manager blueberry"

# shell
deps+=" zsh"

# git
deps+=" git git-delta"

# dev
deps+=" gcc gcc-c++ clang mold cmake openssl openssl-devel systemd-devel dotnet dotnet-sdk-6.0 dotnet-runtime-6.0"
deps+=" perl" # Perl is required when building a project with openssl-devel: https://github.com/openssl/openssl/issues/13761

# multimedia
deps+=" pavucontrol mpv scrot ffmpeg playerctl"

# applications
deps+=" ripgrep keybase stow curl neovim fd-find fzf bat exa lxappearance nnn seahorse file-roller calcurse qalculate parcellite sxiv foliate redshift-gtk"

# password store
deps+=" pass passmenu pinentry-gtk2"

# japanese
deps+=" adobe-source-han-sans-jp-fonts fcitx5 fcitx5-mozc fcitx5-qt fcitx5-qt6 fcitx5-gtk2 fcitx5-gtk3 fcitx5-gtk4"

# Install packages
echo "=========== Ignite! ============"
sudo dnf install -y $deps

echo "========= PowerShell ==========="
# See https://github.com/PowerShell/PowerShell/releases
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.2.6/powershell-7.2.6-1.rh.x86_64.rpm

echo "========== WezTerm ============="
# See https://github.com/wez/wezterm/releases/
sudo dnf install https://github.com/wez/wezterm/releases/download/20220905-102802-7d4b8249/wezterm-20220905_102802_7d4b8249-1.fedora36.x86_64.rpm 

echo "======= Keyboard Layout ========"
sudo localectl set-x11-keymap fr pc105 bepo_afnor
sudo localectl set-keymap fr-bepo_afnor

# Basic dotfile setup
echo "===== Start basic_setup.sh ====="
./basic_setup.sh
