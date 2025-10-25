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
# use ~/git/nu_scripts/custom-completions/git/git-completions.nu *
# use ~/git/nu_scripts/custom-completions/just/just-completions.nu *
# use ~/git/nu_scripts/custom-completions/man/man-completions.nu *
# use ~/git/nu_scripts/custom-completions/make/make-completions.nu *
# use ~/git/nu_scripts/custom-completions/btm/btm-completions.nu *
# use ~/git/nu_scripts/custom-completions/cargo/cargo-completions.nu *

## Zoxide helper
source ~/.config/nushell/.zoxide.nu

## Broot helper
source ~/.config/nushell/.broot.nu
