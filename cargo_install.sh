#!/bin/bash
set -euf -o pipefail

# Pass `--force` to re-compile and install all,
# or `cargo install-update -a` to update only outdated binaries.
# See: https://github.com/nabijaczleweli/cargo-update

~/.cargo/bin/cargo install zoxide $@
~/.cargo/bin/cargo install skim $@
~/.cargo/bin/cargo install starship $@
~/.cargo/bin/cargo install broot $@
~/.cargo/bin/cargo install diskonaut $@
~/.cargo/bin/cargo install watchexec-cli $@
~/.cargo/bin/cargo install tiempo $@
~/.cargo/bin/cargo install tokei $@
~/.cargo/bin/cargo install nu $@
~/.cargo/bin/cargo install just $@
~/.cargo/bin/cargo install subfilter $@
~/.cargo/bin/cargo install fclones $@
~/.cargo/bin/cargo install gitui $@
~/.cargo/bin/cargo install rusty-man $@
~/.cargo/bin/cargo install spotify-tui $@
~/.cargo/bin/cargo install git-absorb $@
~/.cargo/bin/cargo install mdcat $@
~/.cargo/bin/cargo install git-trim $@
~/.cargo/bin/cargo install bandwhich $@
~/.cargo/bin/cargo install pipe-rename $@
~/.cargo/bin/cargo install typos-cli $@
~/.cargo/bin/cargo install cargo-spellcheck $@
~/.cargo/bin/cargo install cargo-update $@
~/.cargo/bin/cargo install cargo-sweep $@
~/.cargo/bin/cargo install cargo-release $@
