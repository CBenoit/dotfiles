#!/bin/bash
set -e

if [[ -d "$1" ]]; then
	tree -L 2 "$1"
else
	bat --color=always "$1"
fi

