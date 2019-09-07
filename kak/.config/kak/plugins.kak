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

	set-option global fzf_preview_width '65%'
	set-option global fzf_preview_height '40%'
	set-option global fzf_preview_tmux_height '40%'

	evaluate-commands %sh{
		if [ -n "$(command -v fd)" ]; then
			echo "set-option global fzf_file_command %{fd . --type f --follow --hidden --exclude .git --exclude .svn}"
		else
			echo "set-option global fzf_file_command %{find . \( -path '*/.svn*' -o -path '*/.git*' \) -prune -o -type f -follow -print}"
		fi
		[ -n "$(command -v bat)" ] && echo "set-option global fzf_highlight_cmd bat"
		[ -n "$(command -v rg)" ] && echo "set-option global fzf_sk_grep_command rg"
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

