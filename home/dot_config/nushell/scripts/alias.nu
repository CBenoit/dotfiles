# --- simple pass-through aliases (extra flags, args still work) ---
alias ll = ls -l
alias latexmk = ^latexmk -lualatex
alias fd = ^fd --follow --hidden
alias mlith = ^monolith --no-audio --ignore-errors --no-frames --no-fonts --isolate --no-js --no-video
alias sf = ^subfilter --time-before 20000 --time-after 40000 --post-replace-pattern "\n" --post-replace-with " "
alias p = ^pueue
alias pa = ^pueue add
alias gsha = ^git rev-parse HEAD # last commit hash
alias gwip = ^git commit -m WIP
alias gdot = ^git commit -m .

def gwippush [] {
  gwip
  ^git push
}

def gdotpush [] {
  gdot
  ^git push
}

def gprdiff [] {
  ^git --no-pager diff | ^bat --decorations=never --paging=never
}

# --- env-driven wrappers / helpers ---
def e [path?: path] {
  if ($env.EDITOR? | is-empty) { error make {msg: "$EDITOR not set"} }
  if $path == null {
    ^($env.EDITOR)
  } else {
    ^($env.EDITOR) $path
  }
}

# ssh with fixed TERM
def ssh [...args] { 
  with-env { TERM: "xterm-256color" } { ^ssh ...$args }
}

# Wine in Japanese locale
def winejp [...args] {
  with-env { LANG: "ja_JP.UTF-8", LC_ALL: "ja_JP" } { ^wine ...$args }
}

# If you have a fuzzy finder in $FINDER, expose it
def finder [...args] {
  if ($env.FINDER? | is-empty) { error make {msg: "$FINDER not set"} }
  ^($env.FINDER) ...$args
}

# screenshot -> clipboard
def scrotclip [] {
  ^scrot -s /tmp/tmpscrot.png
  if ($env.LAST_EXIT_CODE == 0) { ^xclip -selection c -t image/png /tmp/tmpscrot.png }
}

# --- maintenance helpers ---
def cleancargo [] {
  print ">> Clean cargo projects from here <<"
  ^cargo sweep -r --time 15
  ^cargo sweep -r --installed
}

def cleanpaccache [] {
  print ">> Clean paccache <<"
  ^paccache -ruk1
}

def cleanall [] { cleancargo; cleanpaccache }

# --- screen/layout fixes ---
def fixscreen [] {
  ^killall picom
  ^xrandr -s 0
  ^xrandr --output DP-3 --auto --primary --output eDP-1 --right-of DP-3 --auto
}

# --- broot helpers ---
# Jump to common dirs inside broot (uses home path reliably)
alias brsubs = br --cmd $":focus ($nu.home-path)/Downloads/;:focus! ($nu.home-path)/data/etudes/japonais/subs_db/;"

# --- git helpers ---
# Finder-powered git helpers only if $FINDER is set
if (not ($env.FINDER? | is-empty)) {
  def gshow [] { let h = ( ^git_browse_logs.sh | str trim ); ^git show $h }
  def gstat [] { let h = ( ^git_browse_logs.sh | str trim ); ^git show --stat $h }
  def ge []    { let files = ( ^git_browse_status.sh | str trim ); edit $files }
  def grebase [] { let h = ( ^git_browse_logs.sh | str trim ); ^git rebase -i --autosquash $"($h)~1" }
  def greset  [] { let h = ( ^git_browse_logs.sh | str trim ); ^git reset --soft $"($h)~1" }
  def gfixup  [] { 
    let h = ( ^git_browse_logs.sh | str trim )
    ^git commit --fixup $h
    with-env { GIT_SEQUENCE_EDITOR: ":" } { ^git rebase -i --autosquash $"($h)~1" }
  }
  def gadd []  { let files = ( ^git_browse_status.sh | str trim ); ^git add --all $files }
  def glog []  { 
    ^git_browse_logs.sh | str replace -a "\n" "" | ^xclip -i -sel p -f | ^xclip -i -sel c -f 
  }
  def ggrep [] {
    let commit = ( ^git_browse_logs.sh | str trim )
    with-env {
      SKIM_DEFAULT_OPTIONS: "--color=current_bg:24"
      FZF_DEFAULT_OPTS:     "--color=bg+:24"
    } {
      let res = (^($env.FINDER) -c $"git grep -i -n --no-color --column -e '{}' ($commit)" -d ":" --preview 'git_bat_preview.sh {1} {2} {3}' )
      let hash   = ($res | split row ":" | get 0)
      let file   = ($res | split row ":" | get 1)
      let line   = ($res | split row ":" | get 2)
      let column = ($res | split row ":" | get 3)
      let short  = ($hash | str substring 0..8)
      ^git show $"($hash):($file)" | ^nvim -M -c $"file git://($short):($file)" -c $line -c $"normal! ($column)|" -c "set nomodified" -c "filetype detect" -
    }
  }
}

# Fetch and stage changes on a PR locally.
def gpr [pr_id: string] {
  ^git fetch origin master
  ^git fetch origin $"refs/pull/($pr_id)/head"
  ^git switch --detach FETCH_HEAD
  let base = (^git merge-base HEAD origin/master | str trim)
  ^git reset $base
  ^git add --all
}

def gprdone [] {
  ^git clean -f
  ^git switch --discard-changes master
}
