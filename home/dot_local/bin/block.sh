#!/bin/bash
set -euf -o pipefail

path=$(whereis "$1" | cut -d " " -f2)
echo "Blocking $path..."
mv "$path" "$path.blocked"
printf "#!/bin/bash\nxdg-open https://youtu.be/dQw4w9WgXcQ\n" > "$path"
chmod +x "$path"
echo "Done"

