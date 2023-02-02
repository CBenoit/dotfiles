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
	monolith
	tp-note
	cargo-spellcheck
	cargo-update
	cargo-sweep
	cargo-edit
	cargo-watch
)

for crate in ${CRATES[*]}; do
	echo "Install ${crate}"
	~/.cargo/bin/cargo install $crate --locked $@
done
