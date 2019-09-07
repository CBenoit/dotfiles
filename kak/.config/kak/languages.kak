# Inspired by https://github.com/andreyorst/dotfiles/blob/master/.config/kak/languages.kak

# C Cpp Rust Java
evaluate-commands %sh{
	for filetype in c cpp rust java; do
		printf "%s\n" "add-highlighter shared/$filetype/code/functions regex (\w*?)\b(for|if|while)?(\h+)?(?=\() 1:function
					   add-highlighter shared/$filetype/code/field     regex ((?<!\.\.)(?<=\.)|(?<=->))[a-zA-Z](\w+)?\b(?![>\"\(]) 0:meta
					   add-highlighter shared/$filetype/code/method    regex ((?<!\.\.)(?<=\.)|(?<=->))[a-zA-Z](\w+)?(\h+)?(?=\() 0:function
					   add-highlighter shared/$filetype/code/return    regex \breturn\b 0:meta"
	done
	for filetype in c cpp; do
		printf "%s\n" "add-highlighter shared/$filetype/code/types_1 regex \b(v|u|vu)\w+(8|16|32|64)(_t)?\b 0:type
					   add-highlighter shared/$filetype/code/types_2 regex \b(v|u|vu)?(_|__)?(s|u)(8|16|32|64)(_t)?\b 0:type
					   add-highlighter shared/$filetype/code/types_3 regex \b(v|u|vu)(_|__)?(int|short|char|long)(_t)?\b 0:type
					   add-highlighter shared/$filetype/code/types_4 regex \b\w+_t\b 0:type"
	done
	for filetype in cpp rust; do
		printf "%s\n" "add-highlighter shared/$filetype/code/  regex [a-zA-Z](\w+)?(\h+)?(?=::) 0:module"
	done
}

# C/Cpp
hook global WinSetOption filetype=(c|cpp) %{
	set-option window formatcmd 'clang-format'
}

# Rust
hook global WinSetOption filetype=rust %{
	set window formatcmd 'rustfmt'
}
face global SpecialType rgb:de935f,default
add-highlighter shared/rust/code/ regex "((Option)|(Some)|(None)|(Result)|(Ok)|(Err))[\( \n<;,]" 1:SpecialType

# Kakscript
hook global WinSetOption filetype=kak %{
	# display the color corresponding to the rgb color code under the cursor
	hook global NormalIdle .* %{ try %{
		execute-keys -draft -save-regs '' <a-i>w"ay
		echo -markup "{rgb:%reg{a}}████████████████"
	}}
}

