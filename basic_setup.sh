#/bin/bash
set -euf -o pipefail

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
stow -t ~ -S git alacritty neovim powershell i3 i3blocks rofi

## no folding stows
stow -t ~ --no-folding -S scripts

## rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## rust-analyzer
rustup component add rust-src
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

## cargo-managed rust applications
./cargo_install.sh

## zsh
# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# stow config
rm ~/.zshrc
stow -t ~ --no-folding -S zsh
