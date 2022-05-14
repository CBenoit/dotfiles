#/bin/bash
set -euf -o pipefail

if ! command -v curl &> /dev/null; then
	echo "curl is missing"
	exit
fi

VERSION="2.1.52"
ARCHIVE_NAME="anki-$VERSION-linux-qt6.tar.zst"
BIN_FOLDER="anki-$VERSION-linux-qt6"

curl -L "https://github.com/ankitects/anki/releases/download/$VERSION/$ARCHIVE_NAME" --output "$ARCHIVE_NAME"
tar xf "$ARCHIVE_NAME" --directory=$HOME/bin/
rm "$ARCHIVE_NAME"
rm -f "$HOME/bin/anki"
ln -s "$HOME/bin/$BIN_FOLDER/anki" "$HOME/bin/anki"

