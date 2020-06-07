# Plugin Manager
source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload

## For Language Server Protocol
plug "ul/kak-lsp" do %{
    cargo install --locked --force --path .
} config %{
    set global lsp_diagnostic_line_error_sign '║'
    set global lsp_diagnostic_line_warning_sign '┊'
    set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"

    define-command ne          -docstring 'go to next error/warning from lsp' %{ lsp-find-error --include-warnings }
    define-command pe          -docstring 'go to previous error/warning from lsp' %{ lsp-find-error --previous --include-warnings }
    define-command ee          -docstring 'go to current error/warning from lsp' %{ lsp-find-error --include-warnings; lsp-find-error --previous --include-warnings }
    define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

    hook global WinSetOption filetype=(c|cpp|cc|rust|javascript|typescript) %{
        lsp-enable-window
        lsp-auto-hover-enable
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

        # Inlay hints are supported but currently a little it broken
        #hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
        #hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
        #hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
        #hook -once -always window WinSetOption filetype=.* %{
        #    remove-hooks window rust-inlay-hints
        #}
    }

    # hook global WinSetOption filetype=rust %{
    #     hook window BufWritePre .* %{
    #         evaluate-commands %sh{
    #             test -f rustfmt.toml && printf lsp-formatting-sync
    #         }
    #     }
    # }

    hook global KakEnd .* lsp-exit
}

# Kakoune modeline, but with passion. Like vim-airline.
plug "andreyorst/powerline.kak" defer powerline %{
    powerline-theme zenburn
    powerline-separator arrow
    powerline-format git bufname filetype mode_info line_column position
    # powerline-toggle-module line_column off
} config %{
    powerline-start
}

# Vim has a nice features, called expandtab, noexpandtab, and smarttab. This plugin implements those.
plug "andreyorst/smarttab.kak" domain GitLab.com defer smarttab %{
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
plug "alexherbo2/surround.kak" %{
    map global user S ': surround<ret>' -docstring 'Enter surround mode'
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

# Extra text-objects
plug "delapouite/kakoune-text-objects" %{
    text-object-map
}

# Move selections up or down
plug "alexherbo2/move-line.kak" config %{
    map global normal "<c-b>" ': move-line-above<ret>'
    map global normal "<c-a>" ': move-line-below<ret>'
}

# plugin that brings integration with fzf
plug "andreyorst/fzf.kak" config %{
    map global user f ': fzf-mode<ret>f' -docstring "open file with fzf"
    map global user b ': fzf-mode<ret>b' -docstring "change buffer with fzf"
    map global user c ': fzf-mode<ret>'  -docstring "open fzf mode"
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

# Map `w` to move by word instead of word start
plug "alexherbo2/word-select.kak" config %{
    map global normal w ': word-select-next-word<ret>'
    map global normal <a-w> ': word-select-next-big-word<ret>'
    map global normal b ': word-select-previous-word<ret>'
    map global normal <a-b> ': word-select-previous-big-word<ret>'
}

# Personal wiki plugin for Kakoune
plug "TeddyDD/kakoune-wiki" config %{
    wiki-setup %sh{ echo $HOME/wiki }
}

# File explorer side panel for Kakoune editor.
plug "andreyorst/kaktree" domain gitlab.com defer kaktree %{
    map global user 'z' ": kaktree-toggle<ret>" -docstring "toggle filetree panel"
    set-option global kaktree_show_help false
    set-option global kaktree_double_click_duration '0.5'
    set-option global kaktree_indentation 1
} config %{
    hook global WinSetOption filetype=kaktree %{
        remove-highlighter buffer/numbers
        remove-highlighter buffer/matching
        remove-highlighter buffer/wrap
        remove-highlighter buffer/show-whitespaces
    }
    kaktree-enable
}
