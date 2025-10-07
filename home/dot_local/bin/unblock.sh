#!/bin/bash
set -euf -o pipefail

path=$(whereis "$1" | cut -d " " -f2)
echo "Unblocking $path..."
mv "$path.blocked" "$path"
echo "Done"

