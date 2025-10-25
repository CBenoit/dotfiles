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

# --- CLI fuzzy finder (sk > fzf) ---
if ((which sk | length) > 0) {
  $env.FINDER = "sk"
} else if ((which fzf | length) > 0) {
  $env.FINDER = "fzf"
}

# Setup external tools
zoxide init nushell | save -f ~/.config/nushell/.zoxide.nu
broot --print-shell-function nushell | save -f ~/.config/nushell/.broot.nu

# Clone nu_scripts if necessary
if ("~/git/nu_scripts" | path exists) == false {
    let clone_dir = ("~/git/nu_scripts" | path expand)
    git clone --shallow-since="7 days ago" -- git@github.com:nushell/nu_scripts.git $clone_dir
}
