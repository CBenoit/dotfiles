#!/bin/bash
set -euf -o pipefail

# pass `--force` to update

~/.cargo/bin/cargo install zoxide $@
~/.cargo/bin/cargo install skim $@
~/.cargo/bin/cargo install starship $@
~/.cargo/bin/cargo install broot $@
~/.cargo/bin/cargo install diskonaut $@
~/.cargo/bin/cargo install watchexec-cli $@
~/.cargo/bin/cargo install tiempo $@
