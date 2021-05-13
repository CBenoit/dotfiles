# Bootstrap the plugin manager
evaluate-commands %sh{
    plugins="$HOME/.cache/kak/plugins"
    mkdir -p "$plugins"
    [ ! -e "$plugins/plug.kak" ] && git clone -q git@github.com:andreyorst/plug.kak.git "$plugins/plug.kak"
    printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}

# ------------------------ #
## Plugins configurations ##
# ------------------------ #

# Plugin manager for Kakoune
plug "andreyorst/plug.kak" noload config %{
    set-option global plug_always_ensure true
    set-option global plug_profile true
    set-option global plug_install_dir %sh { echo "$HOME/.cache/kak/plugins" }
    hook global WinSetOption filetype=plug %{
        remove-highlighter buffer/numbers
        remove-highlighter buffer/matching
        remove-highlighter buffer/wrap
        remove-highlighter buffer/whitespaces
    }
}

## Colorschemes ##

# Base16 Gruvbox Dark Soft variant colorscheme for Kakoune
plug "andreyorst/base16-gruvbox.kak" noload do %{
    mkdir -p $HOME/.config/kak/colors
    find $PWD -type f -name "*.kak" -exec ln -sf {} $HOME/.config/kak/colors/ \;
} config %{
    colorscheme base16-gruvbox-dark-soft
}

## For Language Server Protocol ##

# Kakoune Language Server Protocol Client
plug "ul/kak-lsp" do %{
    cargo install --locked --force --path .
} config %{
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
plug "andreyorst/smarttab.kak" defer smarttab %{
    set-option global softtabstop 4
    set-option global smarttab_expandtab_mode_name '⋅t⋅'
    set-option global smarttab_noexpandtab_mode_name '→t→'
    set-option global smarttab_smarttab_mode_name '→t⋅'
} config %{
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|perl) expandtab
    hook global WinSetOption filetype=(makefile|sh|gas) noexpandtab
    hook global WinSetOption filetype=(c|cpp) smarttab
}

# Auto-paired characters for Kakoune
plug "alexherbo2/auto-pairs.kak"

# Surround pairs as-you-type for Kakoune
plug "alexherbo2/surround.kak" demand surround %{
    # TODO: check https://github.com/alexherbo2/surround.kak
    map global user S ': enter-user-mode surround<ret>' -docstring 'Enter surround mode'
}

# Plugin for handling snippets.
plug "occivink/kakoune-snippets" config %{
    set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
    set-option global snippets_auto_expand false

    map global normal '#' "bw: snippets-expand-trigger<ret>"
    map global normal <c-f> ": snippets-expand-or-jump<ret>"
    map global insert <c-f> "<esc>: snippets-expand-or-jump<ret>"

    define-command snippets-expand-or-jump %{
        try %{ snippets-expand-trigger %{
            set-register / "%opt{snippets_triggers_regex}"
            execute-keys 'hbs<ret>'
        }} catch %{
            try %{ snippets-select-next-placeholders }
        }
    }
}

# Snippets for various languages.
plug "andreyorst/kakoune-snippet-collection"

# Write to files using 'sudo'
plug "occivink/kakoune-sudo-write"

# Select up and down lines that match the same pattern
plug "occivink/kakoune-vertical-selection" config %{
    map global user   v ': vertical-selection-down<ret>'       -docstring "Select matching patterns below"
    map global user   V ': vertical-selection-up<ret>'         -docstring "Select matching patterns above"
    # New mappings are added by kakoune-text-objects as well (<a-i>v, <a-a>v)
}

plug "occivink/kakoune-find"

# Extra text-objects
# TODO: read doc again
plug "delapouite/kakoune-text-objects" %{
    text-object-map
}

# Move selections up or down
plug "alexherbo2/move-line.kak" demand move-line %{
    map global normal "<c-b>" ': move-line-above<ret>'
    map global normal "<c-a>" ': move-line-below<ret>'
}

# plugin that brings integration with fzf
plug "andreyorst/fzf.kak" config %{
    map global user . ': fzf-mode<ret>f' -docstring "open file"
    map global user * ': fzf-mode<ret>g' -docstring "grep file contents recursively"
    map global user « ': fzf-mode<ret>b' -docstring "change buffer"

    map global project . ': fzf-mode<ret>f' -docstring "open file"
    map global project * ': fzf-mode<ret>g' -docstring "grep file contents recursively"

    map global buffers . ': fzf-mode<ret>b' -docstring "change buffer"
    map global buffers * ': fzf-mode<ret>s' -docstring "search in buffer"

    map global file . ': fzf-mode<ret>f' -docstring "open file"
    map global file v ': fzf-mode<ret>v' -docstring "vsc open file"
} defer fzf %{
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
}

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
plug "alexherbo2/word-select.kak" demand word-select %{
    map global normal é ': word-select-next-word<ret>'
    map global normal <a-é> ': word-select-next-big-word<ret>'
    map global normal e ': word-select-next-word<ret>'
    map global normal <a-e> ': word-select-next-big-word<ret>'
    map global normal b ': word-select-previous-word<ret>'
    map global normal <a-b> ': word-select-previous-big-word<ret>'
}

# Personal wiki plugin for Kakoune
plug "TeddyDD/kakoune-wiki" config %{
    wiki-setup %sh{ echo $HOME/wiki }
}

plug "whereswaldon/shellcheck.kak"

# TODO: kakoune-auto-percent
# TODO: https://github.com/danr/kakoune-easymotion

