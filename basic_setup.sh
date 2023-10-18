#/bin/bash
set -euf -o pipefail

## config

git_folder=~/git

## check some dependencies

if ! command -v stow &> /dev/null; then
	echo "stow is missing"
	exit
fi

if ! command -v git &> /dev/null; then
	echo "git is missing"
	exit
fi

if ! command -v curl &> /dev/null; then
	echo "curl is missing"
	exit
fi

if ! command -v gcc &> /dev/null; then
	echo "gcc is missing"
	exit
fi

## easy stows
stow -t ~ -S git powershell i3 i3blocks rofi starship wezterm tp-note broot

## no folding stows
stow -t ~ --no-folding -S scripts helix nushell

## rust toolchain
curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh

## gef (gdb enhanced features)
wget -O ~/.gdbinit-gef.py -q https://gef.blah.cat/py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

## zsh
# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# stow config
rm ~/.zshrc
stow -t ~ --no-folding -S zsh

# Setup git
mkdir -p "$git_folder" 

## Nushell
## TODO: full switch to nushell

## Helix
mkdir -p "$git_folder" 
git clone --shallow-since="7 days ago" -- https://github.com/helix-editor/helix "$git_folder/helix"
cd helix
cargo install --path helix-term --locked
ln -s "$PWD/runtime" ~/.config/helix/runtime
hx --grammar fetch
hx --grammar build

## Anki
./install_anki.sh

## Pueue
systemctl --user enable pueued.service
systemctl --user start pueued.service
