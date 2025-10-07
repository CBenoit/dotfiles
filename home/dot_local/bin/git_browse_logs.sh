#!/bin/bash
set -e

if [[ $1 == "multi" ]]; then
  other_args="--multi --bind tab:toggle"
else
  other_args=""
fi

export SKIM_DEFAULT_OPTIONS='--tiebreak index,score --color=current_bg:24'
export FZF_DEFAULT_OPTS='--tiebreak index --color=bg+:24'
HASH=$(git log --oneline --decorate --color=always --max-count 200 | $FINDER --ansi -d" " $other_args --preview "git show --color=always {1}")
echo "$HASH" | cut -d" " -f1
