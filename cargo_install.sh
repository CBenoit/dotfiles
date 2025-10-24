#!/bin/bash
set -euf -o pipefail

# Newer versions of cargo reinstall already installed packages if out of date.
# See: https://doc.rust-lang.org/cargo/commands/cargo-install.html
# To update all packages, just run this script again.
# Alternatively, `cargo install-update -a` can be used (especially if user installed
# additional packages not listed here)
# See: https://github.com/nabijaczleweli/cargo-update

echo "Install cargo-binstall"
~/.cargo/bin/cargo +stable install cargo-binstall --locked $@

CRATES=(
	git-trim
	typos-cli
	kondo
	bacon
	watchexec
	cargo-update
	cargo-sweep
	cargo-edit
	cargo-nextest
	cargo-bloat
	cargo-careful
)

for crate in ${CRATES[*]}; do
	echo "Install ${crate}"
	~/.cargo/bin/cargo +stable binstall $crate --locked $@
done

# Install cargo-show-asm separately, because I want the extra features
echo "Install cargo-show-asm"
~/.cargo/bin/cargo +stable install cargo-show-asm --locked --features dull-color $@
