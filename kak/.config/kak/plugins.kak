# Run this if alexherbo2/plug.kak is not installed yet
# ```
# git clone https://github.com/alexherbo2/plug.kak ~/.config/kak/autoload/plugins/plug
# ```
require-module plug

# ------------------------ #
## Plugins configurations ##
# ------------------------ #

# Let plug.kak manage itself
plug plug "https://github.com/alexherbo2/plug.kak" %{
    define-command plug-upgrade -docstring 'upgrade plugins and build' %{
        plug-install
        plug-execute lsp cargo install --locked --force --path .
    }
}

## Colorschemes ##

# Base16 Gruvbox Dark Soft variant colorscheme for Kakoune
# plug-old base16-gruvbox "https://github.com/andreyorst/base16-gruvbox.kak" %{
#     colorscheme base16-gruvbox-dark-soft
# }

## For Language Server Protocol ##

# Kakoune Language Server Protocol Client
plug-old lsp "https://github.com/ul/kak-lsp" %{
    set global lsp_diagnostic_line_error_sign '║'
    set global lsp_diagnostic_line_warning_sign '┊'
    # set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"

    define-command ne          -docstring 'go to next error/warning from lsp' %{ lsp-find-error --include-warnings }
    define-command pe          -docstring 'go to previous error/warning from lsp' %{ lsp-find-error --previous --include-warnings }
    define-command ee          -docstring 'go to current error/warning from lsp' %{ lsp-find-error --include-warnings; lsp-find-error --previous --include-warnings }
    define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

    hook global WinSetOption filetype=(c|cpp|cc|rust|javascript|typescript) %{
        lsp-enable-window
        lsp-auto-hover-disable
        lsp-auto-hover-insert-mode-disable

        set-option window lsp_auto_highlight_references true
        set-option window lsp_hover_anchor false
        set-face window DiagnosticError red,default+u
        set-face window DiagnosticWarning rgb:ffb070,default+u

        map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"

        echo -debug "Enabling LSP for filtetype %opt{filetype}"
    }

    hook global WinSetOption filetype=(c|cpp) %sh{
        # Add clangd files to git exclude file
        if [[ ! $(env cat .git/info/exclude | grep "by kakoune: clangd") ]]; then
            printf "\n# by kakoune: clangd\n.clangd\ncompile_commands.json\n" >> .git/info/exclude
        fi
    }

    hook global WinSetOption filetype=(rust) %{
        set window lsp_server_configuration rust.clippy_preference="on"

        hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
        hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
        hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
        hook -once -always window WinSetOption filetype=.* %{
           remove-hooks window rust-inlay-hints
        }
    }

    hook global KakEnd .* lsp-exit
}

# Vim has a nice features, called expandtab, noexpandtab, and smarttab. This plugin implements those.
plug smarttab "https://github.com/andreyorst/smarttab.kak" %{
    set-option global softtabstop 4
    set-option global smarttab_expandtab_mode_name '⋅t⋅'
    set-option global smarttab_noexpandtab_mode_name '→t→'
    set-option global smarttab_smarttab_mode_name '→t⋅'

    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|perl) expandtab
    hook global WinSetOption filetype=(makefile|sh|gas) noexpandtab
    hook global WinSetOption filetype=(c|cpp) smarttab
}

# Auto-paired characters for Kakoune
plug auto-pairs "https://github.com/ALEXHERBO2/auto-pairs.kak" %{
    auto-pairs-enable
}

# Surround pairs as-you-type for Kakoune
plug surround "https://github.com/alexherbo2/surround.kak" %{
    # TODO: check doc again https://github.com/alexherbo2/surround.kak
    # + redo mappings
    map global user S ': enter-user-mode surround<ret>' -docstring 'Surround'
}

# Write to files using 'sudo'
plug-old sudo-write "https://github.com/occivink/kakoune-sudo-write"

# Select up and down lines that match the same pattern
plug-old vertical-selection "https://github.com/occivink/kakoune-vertical-selection" %{
    map global user   v ': vertical-selection-down<ret>' -docstring "Select matching patterns below"
    map global user   V ': vertical-selection-up<ret>'   -docstring "Select matching patterns above"
    # New mappings are added by kakoune-text-objects as well (<a-i>v, <a-a>v)
}

plug-old find "https://github.com/occivink/kakoune-find"

# Extra text-objects
# TODO: read doc again
plug-old text-objects "https://github.com/delapouite/kakoune-text-objects" %{
    text-object-map
}

# Move selections up or down
plug move-line "https://github.com/alexherbo2/move-line.kak" %{
    map global normal "<c-b>" ': move-line-above<ret>'
    map global normal "<c-a>" ': move-line-below<ret>'
}

# plugin that brings integration with fzf
plug fzf "https://github.com/andreyorst/fzf.kak" %{
    set-option global fzf_preview_width '65%'
    set-option global fzf_project_use_tilda true

    declare-option str-list fzf_exclude_files "*.o" "*.bin" "*.obj" ".*cleanfiles"
    declare-option str-list fzf_exclude_dirs ".git" ".svn" "rtlrun*" "target" "build" "cmake-build-debug" "cmake-release-debug" ".clangd"

    set-option global fzf_file_command %sh{
        if [ -n "$(command -v fd)" ]; then
            eval "set -- $kak_quoted_opt_fzf_exclude_files $kak_quoted_opt_fzf_exclude_dirs"
            while [ $# -gt 0 ]; do
                exclude="$exclude --exclude '$1'"
                shift
            done
            cmd="fd . --no-ignore --type f --follow --hidden $exclude"
        else
            eval "set -- $kak_quoted_opt_fzf_exclude_files"
            while [ $# -gt 0 ]; do
                exclude="$exclude -name '$1' -o"
                shift
            done
            eval "set -- $kak_quoted_opt_fzf_exclude_dirs"
            while [ $# -gt 1 ]; do
                exclude="$exclude -path '*/$1' -o"
                shift
            done
            exclude="$exclude -path '*/$1'"
            cmd="find . \( $exclude \) -prune -o -type f -follow -print"
        fi
        echo "$cmd"
    }

    if %[ -n "$(command -v bat)" ] %{
        set-option global fzf_highlight_command 'bat'
    }

    if %[ -n "$(command -v sk)" ] %{
        set-option global fzf_implementation 'sk'
    }

    if %[ -n "$(command -v rg)" ] %{
        set-option global fzf_grep_command 'rg'
    }

    map global user . ': fzf-mode<ret>f' -docstring "open file"
    map global user * ': fzf-mode<ret>g' -docstring "grep file contents recursively"
    map global user « ': fzf-mode<ret>b' -docstring "change buffer"

    map global project . ': fzf-mode<ret>f' -docstring "open file"
    map global project * ': fzf-mode<ret>g' -docstring "grep file contents recursively"

    map global buffers . ': fzf-mode<ret>b' -docstring "change buffer"
    map global buffers * ': fzf-mode<ret>s' -docstring "search in buffer"

    map global file . ': fzf-mode<ret>f' -docstring "open file"
    map global file v ': fzf-mode<ret>v' -docstring "vsc open file"
}

# TODO: check this
# } defer fzf %{
#     set-option global fzf_preview_width '65%'
#     if %[ -n "$(command -v bat)" ] %{
#         set-option global fzf_highlight_command bat
#     }
# } defer fzf-project %{
#     set-option global fzf_project_use_tilda true
# } defer fzf-file %{
#     declare-option str-list fzf_exclude_files "*.o" "*.bin" "*.obj" ".*cleanfiles"
#     declare-option str-list fzf_exclude_dirs ".git" ".svn"
#     set-option global fzf_file_command %sh{
#         if [ -n "$(command -v fd)" ]; then
#             eval "set -- ${kak_quoted_opt_fzf_exclude_files:-} ${kak_quoted_opt_fzf_exclude_dirs:-}"
#             while [ $# -gt 0 ]; do
#                 exclude="$exclude --exclude '$1'"
#                 shift
#             done
#             cmd="fd . --no-ignore --type f --follow --hidden $exclude"
#         else
#             eval "set -- $kak_quoted_opt_fzf_exclude_files"
#             while [ $# -gt 0 ]; do
#                 exclude="$exclude -name '$1' -o"
#                 shift
#             done
#             eval "set -- $kak_quoted_opt_fzf_exclude_dirs"
#             while [ $# -gt 0 ]; do
#                 exclude="$exclude -path '*/$1' -o"
#                 shift
#             done
#             cmd="find . \( ${exclude% -o} \) -prune -o -type f -follow -print"
#         fi
#         echo "$cmd"
#     }
# }

# Map `w` to move by word instead of word start
plug word-select "https://github.com/alexherbo2/word-select.kak" %{
    map global normal é ': word-select-next-word<ret>'
    map global normal <a-é> ': word-select-next-big-word<ret>'
    map global normal e ': word-select-next-word<ret>'
    map global normal <a-e> ': word-select-next-big-word<ret>'
    map global normal b ': word-select-previous-word<ret>'
    map global normal <a-b> ': word-select-previous-big-word<ret>'
}

# Personal wiki plugin for Kakoune
plug-old wiki "https://github.com/TeddyDD/kakoune-wiki" %{
    wiki-setup %sh{ echo $HOME/wiki }
}

plug-old shellcheck "https://github.com/whereswaldon/shellcheck.kak"

# TODO: https://github.com/Delapouite/kakoune-auto-percent
# TODO: https://github.com/danr/kakoune-easymotion
# TODO: https://github.com/alexherbo2/view-mode.kak
# TODO: https://github.com/alexherbo2/yank-ring.kak
# TODO: https://github.com/alexherbo2/alacritty.kak
# TODO: https://github.com/kakounedotcom/connect.kak + https://discuss.kakoune.com/t/connect-kak-built-in-integrations-framework-and-workflow/1243 + https://github.com/alexherbo2/kakoune.cr#readme
# TODO: https://github.com/occivink/kakoune-phantom-selection
# TODO: https://gitlab.com/Screwtapello/kakoune-mark-show
# TODO: https://github.com/alexherbo2/phantom.kak
# TODO: https://github.com/alexherbo2/edit.kak
# TODO: https://github.com/alexherbo2/view-mode.kak
# TODO: https://github.com/alexherbo2/text-objects.kak
# TODO: https://github.com/alexherbo2/split-object.kak
# TODO: https://github.com/alexherbo2/palette.kak
# TODO: https://github.com/ul/kak-tree ; see: https://github.com/vbauerster/dotfiles/blob/master/config/kak/plugins.kak#L130

