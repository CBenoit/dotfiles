#!/bin/bash
set -e
export SKIM_DEFAULT_OPTIONS='--tiebreak index,score --color=current_bg:24'
export FZF_DEFAULT_OPTS='--tiebreak index --color=bg+:24'
HASH=$(git log --oneline --decorate --color=always --max-count 200 | $FINDER --ansi -d" " --preview "git show --color=always {1}")
echo $HASH | cut -d" " -f1
