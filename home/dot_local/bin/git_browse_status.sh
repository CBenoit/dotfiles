#!/bin/bash
set -eo pipefail
cd $(git rev-parse --show-toplevel)
export SKIM_DEFAULT_OPTIONS='--color=current_bg:24'
export FZF_DEFAULT_OPTS='--color=bg+:24'
git status --porcelain=v1 --ignored | cut -c 1 --complement | $FINDER -m -d" " --preview "git_status_file_preview.sh '{2}'" | cut -d" " -f2
