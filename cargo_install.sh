#!/bin/bash
set -euf -o pipefail

# Newer versions of cargo reinstall already installed packages if out of date.
# See: https://doc.rust-lang.org/cargo/commands/cargo-install.html
# To update all packages, just run this script again.
# Alternatively, `cargo install-update -a` can be used (especially if user installed
# additional packages not listed here)
# See: https://github.com/nabijaczleweli/cargo-update

CRATES=(
	zoxide
	skim
	starship
	broot
	diskonaut
	watchexec-cli
	tiempo
	tokei
	just
	subfilter
	fclones
	gitui
	rusty-man
	git-absorb
	mdcat
	git-trim
	pipe-rename
	typos-cli
	bacon
	dust
	kondo
	topgrade
	cocogitto
	cargo-spellcheck
	cargo-update
	cargo-sweep
	cargo-edit
	cargo-watch
	bandwhich
)

for crate in ${CRATES[*]}; do
	~/.cargo/bin/cargo install $crate --locked $@
done

# Install nushell separately, because I want the extra features
~/.cargo/bin/cargo install nu --locked --features extra $@
