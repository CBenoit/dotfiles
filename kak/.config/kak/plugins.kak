# Plugin Manager
source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload

## For Language Server Protocol
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
		set-face window DiagnosticWarning rgb:ffb070,default+u
	}

	hook global WinSetOption filetype=rust %{
		set-option window lsp_server_configuration rust.clippy_preference="on"
	}

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
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|sh|perl) expandtab
    hook global WinSetOption filetype=(makefile|gas) noexpandtab
    hook global WinSetOption filetype=(c|cpp) smarttab
}

# Automatically insert pair symbols, like braces, quotes, etc. Also allows surrounding text.
plug "alexherbo2/auto-pairs.kak" %{
	# hook global WinCreate .* %{
	# 	auto-pairs-enable
	# }
	map global user s -docstring 'Surround' ':<space>auto-pairs-surround<ret>'
	map global user S -docstring 'Surround++' ':<space>auto-pairs-surround _ _ * *<ret>'
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
	map global user   v ': select-down<ret>'       -docstring "Select matching patterns below"
	map global user   V ': select-up<ret>'         -docstring "Select matching patterns above"
	map global normal ^ ': select-vertically<ret>' -docstring "Select matching patterns above and below"
}

# Extra text-objects
plug "delapouite/kakoune-text-objects"

# Move selections up or down
plug "alexherbo2/move-line.kak" config %{
	map global normal "<c-b>" ': move-line-above %val{count}<ret>'
	map global normal "<c-a>" ': move-line-below %val{count}<ret>'
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
    declare-option str-list fzf_exclude_dirs ".git" ".svn" "rtlrun*"
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
        set-option global fzf_highlight_command bat
    }

    if %[ -n "$(command -v sk)" ] %{
        set-option global fzf_implementation sk
    }

    if %[ -n "${kak_opt_grepcmd}" ] %{
        set-option global fzf_sk_grep_command %{${kak_opt_grepcmd}}
    }
}

# Source outline viewer for Kakoune
# plug "andreyorst/tagbar.kak" config %{
# 	set-option global tagbar_sort false
# 	set-option global tagbar_size 40
# 	set-option global tagbar_display_anon false
# 	map global user "<c-t>" ": tagbar-toggle<ret>" -docstring "toggle tagbar panel"

# 	hook global WinSetOption filetype=tagbar %{
# 		remove-highlighter window/wrap
# 		remove-highlighter window/whitespaces
# 		remove-highlighter window/numbers
# 		remove-highlighter window/matching
# 	}

# 	# To see what filetypes are supported use `ctags --list-kinds | awk '/^\w+/'
# 	hook global WinSetOption filetype=(c|cpp|rust|python) %{
# 	    tagbar-enable
# 	}
# }

# Simpler word movements for Kakoune
# plug "alexherbo2/word-movement.kak" config %{
# 	word-movement-map next w

# 	word-movement-map previous b
# 	map global normal B     ': word-movement-previous-word-extending<ret><a-;>'
# 	map global normal <a-B> ': word-movement-previous-big-word-extending<ret><a-;>'
# }

