# Nushell Environment Config File

# pager
$env.MANPAGER = "sh -c 'col -bx | bat --plain --language man'"
$env.MANROFFOPT = -c

# editor
$env.EDITOR = "hx"
$env.VISUAL = $env.EDITOR
$env.HELIX_RUNTIME = "/home/auroden/git/helix/runtime"

# fzf
$env.FZF_DEFAULT_COMMAND = "fd --hidden --exclude .git --exclude node_modules"

# CLI fuzzy finder (sk > fzf)
if ((which sk | length) > 0) {
  $env.FINDER = "sk"
} else if ((which fzf | length) > 0) {
  $env.FINDER = "fzf"
}

# Lets carapace reuse other shells' defs.
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

# Setup external tools (all of this could actually be run only once, outside of env.nu)
let user_autoload_dir = $nu.data-dir | path join "vendor/autoload"
mkdir $user_autoload_dir

zoxide init nushell | save --force ($user_autoload_dir | path join "zoxide.nu")

broot --print-shell-function nushell | save --force ($user_autoload_dir | path join "broot.nu")

starship init nu | save --force ($user_autoload_dir | path join "starship.nu")

carapace _carapace nushell | save --force ($user_autoload_dir | path join "carapace.nu")

# Clone nu_scripts if necessary.
mkdir $nu.data-dir
let nu_scripts_clone_dir = $"($nu.data-dir)/nu_scripts"
if ($nu_scripts_clone_dir | path exists) == false {
  git clone --depth=1 https://github.com/nushell/nu_scripts.git $nu_scripts_clone_dir
}
