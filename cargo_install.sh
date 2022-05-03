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
	spotify-tui
	git-absorb
	mdcat
	git-trim
	bandwhich
	pipe-rename
	typos-cli
	cocogitto
	cargo-spellcheck
	cargo-update
	cargo-sweep
	cargo-release
	cargo-watch
)

for crate in ${CRATES[*]}; do
	~/.cargo/bin/cargo install $crate $@
done

# Install nushell separately, because I want the extra features
~/.cargo/bin/cargo install nu --features extra $@
