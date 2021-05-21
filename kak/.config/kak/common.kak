# To use the System Clipboard (https://github.com/mawww/kakoune/wiki/Registers---Clipboard)
# TODO: change this behavior
hook global NormalKey y|d|c %{ nop %sh{
    printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}

# Avoid the escape key (https://github.com/mawww/kakoune/wiki/Avoid-the-escape-key)
hook global InsertChar c %{ try %{
    exec -draft hH <a-k>,c<ret> d
    exec <esc>
}}

# Indentation (see smarttab.kak plugin configuration in plugins.kak)
set-option global tabstop 4
set-option global indentwidth 4 # 0 for "\t" instead of spaces (however I use smarttab.kak to handle this instead)

# Keep 3 lines and 3 columns visible around cursor when scrolling
set-option global scrolloff 3,3

# Custom faces
set-face global TrailingSpace default,red
set-face global delimiters rgb:f0d080,default

# Highlighters
hook global WinCreate .* %{
    add-highlighter window/numbers     number-lines -relative -hlcursor
    add-highlighter window/matching    show-matching
    # add-highlighter window/wrap        wrap -word -indent -marker ↳
    # add-highlighter window/whitespaces show-whitespaces -lf ' '
    add-highlighter window/operators   regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~) 0:operator
    add-highlighter window/delimiters  regex (\(|\)|\[|\]|\{|\}|\;|') 0:delimiters
    add-highlighter window/trailing    regex '([  ]+)\n' 1:TrailingSpace
}

# TODO: should probably be a manual operation, maybe in my `project` user mode.
# cd to project root on new window and try to auto load editorconfig file
hook global WinCreate ^[^*]+$ %{
    cd-project-root

    evaluate-commands %sh{ if [[ -f ".editorconfig" ]]; then
        echo "echo -debug Found .editorconfig in project root! Attempt to load..."
        echo "editorconfig-load .editorconfig"
    fi }
}

# git stuff
hook global BufWritePost .* %{
    git update-diff
}
hook global BufReload .* %{
    git update-diff
}
hook global WinCreate .* %{
    git show-diff
}

# set ncurse assistant to a cat!
set-option global ui_options ncurses_assistant=cat

# display the status bar on top
set-option global ui_options ncurses_status_on_top=true

