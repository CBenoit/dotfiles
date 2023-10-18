#!/bin/bash
set -euf -o pipefail

#### ==================================================== ####
## Configuration bootstrap for Manjaro i3 community edition ##
#### ==================================================== ####

# Update the mirrorlist
sudo pacman-mirrors -c Canada,France,Japan

# Initial upgrade (partial upgrades are unsupported)
sudo pacman -Syu

# wm, i3
deps+=" i3-gaps rofi pcmanfm wezterm ttf-fira-code ttf-font-awesome libnotify picom mediainfo bc polkit-gnome xfce4-power-manager blueman volumeicon dunst i3exit xautolock nitrogen pa-applet"

# shell
deps+=" zsh nushell ripgrep ripgrep-all stow curl fd fzf skim bat exa zoxide nmap sd pueue"

# git
deps+=" git git-delta git-absorb"

# dev
deps+=" gcc clang gdb mold cmake openssl dotnet-host dotnet-sdk dotnet-runtime python python-pip strace"
deps+=" binaryen" # Toolchain infrastructure for WASM
deps+=" yasm" # Assembler
deps+=" perl" # Perl is required when building a project with openssl-devel: https://github.com/openssl/openssl/issues/13761

# multimedia
deps+=" pavucontrol mpv scrot ffmpeg playerctl"

# applications
deps+=" keybase kbfs keybase-gui neovim lxappearance nnn seahorse file-roller calcurse clipit sxiv foliate redshift pass just tokei watchexec diskonaut broot starship gitui mdcat bacon dust topgrade bottom bandwhich cocogitto pipe-rename zathura zathura-pdf-mupdf zathura-djvu firefox nyxt tealdeer ncspot dysk"

# japanese
deps+=" adobe-source-han-sans-jp-fonts fcitx5 fcitx5-mozc fcitx5-qt fcitx5-gtk fcitx5-configtool"

# Install packages
echo "=========== Ignite! ============"
sudo pacman -S $deps

echo "====== Prepare AUR folder ======"
mkdir -p ~/.local/aur-build

echo "========= PowerShell ==========="
# https://wiki.archlinux.org/title/Arch_User_Repository#Installing_and_upgrading_packages
# FIXME: for security reasons: switch to a snapshot?
old_pwd=$(pwd)
pushd ~/.local/aur-build
rm -rf powershell-bin
git clone https://aur.archlinux.org/powershell-bin.git
cd powershell-bin
makepkg -sirc
popd

# Basic dotfile setup
echo "===== Start basic_setup.sh ====="
./basic_setup.sh

# cargo-managed rust applications
echo "===== Start cargo_install.sh ====="
./cargo_install.sh

