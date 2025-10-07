#!/bin/bash
set -euf -o pipefail

# Newer versions of cargo reinstall already installed packages if out of date.
# See: https://doc.rust-lang.org/cargo/commands/cargo-install.html
# To update all packages, just run this script again.
# Alternatively, `cargo install-update -a` can be used (especially if user installed
# additional packages not listed here)
# See: https://github.com/nabijaczleweli/cargo-update

CRATES=(
	tiempo
	subfilter
	fclones
	rusty-man
	git-trim
	typos-cli
	kondo
	cargo-update
	cargo-sweep
	cargo-edit
	cargo-watch
	cargo-nextest
	ast-grep
	wiki-tui
	trashy
	difftastic
)

for crate in ${CRATES[*]}; do
	echo "Install ${crate}"
	~/.cargo/bin/cargo +stable install $crate --locked $@
done

# Install cargo-show-asm separately, because I want the extra features
~/.cargo/bin/cargo +stable install cargo-show-asm --locked --features dull-color $@

# TODO: use cargo-binstall?
