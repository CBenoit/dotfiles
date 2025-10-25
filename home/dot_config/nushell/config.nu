###=============================================================================================###
###################################### Nushell Config File ########################################
###=============================================================================================###
# Other users’ config:
# - https://github.com/kurokirasama/nushell_scripts
# - https://github.com/Eldyj/nu-config
# - https://github.com/goatfiles/dotfiles/tree/fb70ea5d18f905ec1187414ae06697a4ab40376a/.config/nushell
###=============================================================================================###

## Update $env.config
source my_config.nu

## Define command aliases
source alias.nu

## Completions
use ~/.local/share/nushell/nu_scripts/custom-completions/btm/btm-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/cargo/cargo-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/cargo-make/cargo-make-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/croc/croc-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/curl/curl-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/docker/docker-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/dotnet/dotnet-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/gh/gh-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/git/git-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/just/just-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/less/less-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/make/make-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/man/man-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/nix/nix-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/npm/npm-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/pnpm/pnpm-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/rg/rg-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/rustup/rustup-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/ssh/ssh-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/tar/tar-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/tcpdump/tcpdump-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/tealdeer/tldr-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/vscode/vscode-completions.nu *
use ~/.local/share/nushell/nu_scripts/custom-completions/zoxide/zoxide-completions.nu *
