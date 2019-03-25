
# Plugin Manager
source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload

# For Language Server Protocol
plug "ul/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force --path . # `--path .' is needed by recent versions of cargo
} config %{
    define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

    define-command ne -docstring 'go to next error/warning from lsp' %{
        lsp-find-error --include-warnings
    }

    define-command pe -docstring 'go to previous error/warning from lsp' %{
        lsp-find-error --previous --include-warnings
    }

    set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"
    set-option global lsp_diagnostic_line_error_sign '║'
    set-option global lsp_diagnostic_line_warning_sign '┊'

    hook global WinSetOption filetype=(c|cpp|rust) %{
        lsp-auto-hover-enable
        lsp-enable-window
        lsp-auto-hover-insert-mode-disable

        map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"

        set-option window lsp_auto_highlight_references true
        set-option window lsp_hover_anchor true

        set-face window DiagnosticError red,default+u
        set-face window DiagnosticWarning orange,default+d
    }

    hook global WinSetOption filetype=rust %{
        set-option window lsp_server_configuration rust.clippy_preference="on"
    }

    hook global WinSetOption filetype=rust %{
        hook window BufWritePre .* %{
            evaluate-commands %sh{
                test -f rustfmt.toml && printf lsp-formatting-sync
            }
        }
    }

	hook global KakEnd .* lsp-exit
}

# Kakoune modeline, but with passion. Like vim-airline.
plug "andreyorst/powerline.kak" %{
    hook -once global WinCreate .* %{
        powerline-theme zenburn
        powerline-separator arrow
        powerline-format git bufname filetype mode_info line_column position
        powerline-toggle line_column off
    }
}

# Vim has a nice features, called expandtab, noexpandtab, and smarttab. This plugin implements those.
plug "andreyorst/smarttab.kak" %{
    set-option global softtabstop 4
    hook global WinSetOption filetype=(c|cpp|rust) smarttab
}

# Automatically insert pair symbols, like braces, quotes, etc. Also allows surrounding text.
plug "alexherbo2/auto-pairs.kak" %{
    map global user 's' ': auto-pairs-surround<ret>' -docstring "surround selection"
}

# Base16 Gruvbox inspired color-scheme.
plug "andreyorst/base16-gruvbox.kak" theme %{
    colorscheme base16-gruvbox-dark-soft
}

# Plugin for handling snippets.
plug "occivink/kakoune-snippets" config %{
    set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
    set-option global snippets_auto_expand false
    map global insert '<tab>' "z<a-;>: snippets-expand-or-jump 'tab'<ret>"
    map global normal '<tab>' ": snippets-expand-or-jump 'tab'<ret>"

    hook global InsertCompletionShow .* %{
        try %{
            execute-keys -draft 'h<a-K>\h<ret>'
            map window insert '<ret>' "z<a-;>: snippets-expand-or-jump 'ret'<ret>"
        }
    }

    hook global InsertCompletionHide .* %{
        unmap window insert '<ret>' "z<a-;>: snippets-expand-or-jump 'ret'<ret>"
    }

    define-command snippets-expand-or-jump -params 1 %{
        execute-keys <backspace>
        try %{ snippets-expand-trigger %{
            set-register / "%opt{snippets_triggers_regex}\z"
            execute-keys 'hGhs<ret>'
        }} catch %{
            snippets-select-next-placeholders
        } catch %sh{
            printf "%s\n" "execute-keys -with-hooks <$1>"
        }
    }
}

# Snippets for various languages.
plug "andreyorst/kakoune-snippet-collection"

