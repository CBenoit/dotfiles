#!/bin/bash

VERSION=$1
STEAM_GAME_ID=$2
PROTON_DIST="~/.steam/steam/steamapps/common/Proton $VERSION/dist"

echo "WINEVERPATH='$PROTON_DIST'"
echo "PATH='$PROTON_DIST/bin:$PATH'"
echo "WINESERVER='$PROTON_DIST/bin/wineserver'"
echo "WINELOADER='$PROTON_DIST/bin/wine'"
echo "WINEDLLPATH='$PROTON_DIST/lib/wine/fakedlls'"
echo "LD_LIBRARY_PATH='"$PROTON_DIST/lib:$LD_LIBRARY_PATH"'"
echo "WINEPREFIX='~/.steam/steam/steamapps/compatdata/$STEAM_GAME_ID/pfx'"
