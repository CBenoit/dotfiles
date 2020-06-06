# Inspired by https://github.com/andreyorst/dotfiles/blob/master/.config/kak/recentf.kak

hook global BufOpenFile .* recentf-add-file
hook global BufWritePost .* recentf-add-file

declare-option -docstring "Path to the file where to store recent file list." \
str recentf_file "/tmp/.kak_recentf"

declare-option -docstring "Maximum amount of entries in the recent file list." \
int max_recentf_files 50

define-command -hidden recentf-add-file %{ nop %sh{
    if grep -q "${kak_buffile}" "${kak_opt_recentf_file}"; then
        # store full recentf list without current entry
        old=$(grep -v "${kak_buffile}" "${kak_opt_recentf_file}")
        # move current entry to the beginning of the list
        printf "%s\n%s\n" "${kak_buffile}" "${old}" > "${kak_opt_recentf_file}"
    else
        # put current entry to the beginning of the list
        printf "%s\n%s\n" "${kak_buffile}" "$(cat ${kak_opt_recentf_file})" > "${kak_opt_recentf_file}"
        # remove everyting past the `max_recentf_files' count
        printf "%s\n" "$(head -${kak_opt_max_recentf_files} ${kak_opt_recentf_file})" > "${kak_opt_recentf_file}"
    fi
}}

# fzf.kak support
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
hook global ModuleLoaded fzf %§

map global fzf -docstring "recent files" 'r' '<esc>: fzf-recentf<ret>'

define-command -hidden fzf-recentf %{ evaluate-commands %sh{
    cmd="cat ${kak_quoted_opt_recentf_file} 2>/dev/null"
    message="Open single or multiple recent files.
<ret>: open file in new buffer.
$kak_opt_fzf_window_map: open file in new terminal"
    [ ! -z "${kak_client_env_TMUX}" ] && tmux_keybindings="
$kak_opt_fzf_horizontal_map: open file in horizontal split
$kak_opt_fzf_vertical_map: open file in vertical split"

    printf "%s\n" "info -title 'fzf recentf' '$message$tmux_keybindings'"
    [ ! -z "${kak_client_env_TMUX}" ] && additional_flags="--expect $kak_opt_fzf_vertical_map --expect $kak_opt_fzf_horizontal_map"
    printf "%s\n" "fzf -preview -kak-cmd %{edit -existing} -items-cmd %{$cmd} -fzf-args %{-m --expect $kak_opt_fzf_window_map $additional_flags --reverse}"
}}

§
