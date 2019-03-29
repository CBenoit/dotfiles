# From https://github.com/andreyorst/dotfiles/blob/master/.config/kak/tmux.kak

define-command -override -docstring "split tmux vertically" \
vsplit -params .. -command-completion %{
    tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}

define-command -override  -docstring "split tmux horizontally" \
split -params .. -command-completion %{
    tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}

define-command -override -docstring "create new tmux window" \
tabnew -params .. -command-completion %{
    tmux-terminal-window kak -c %val{session} -e "%arg{@}"
}

