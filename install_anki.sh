#/bin/bash
set -euf -o pipefail

if ! command -v curl &> /dev/null; then
	echo "curl is missing"
	exit
fi

VERSION="2.1.48"
curl -L "https://github.com/ankitects/anki/releases/download/$VERSION/anki-$VERSION-linux.tar.bz2" --output "anki-$VERSION-linux.tar.bz2"
tar xf "anki-$VERSION-linux.tar.bz2" --directory=$HOME/bin/
rm "anki-$VERSION-linux.tar.bz2"
rm -f "$HOME/bin/Anki"
ln -s "$HOME/bin/anki-$VERSION-linux/bin/Anki" "$HOME/bin"

