#!/bin/bash
# from https://stackoverflow.com/questions/9144551/identifying-mp3-not-by-name-with-shell-script/9145286#9145286
find . -type f -printf '%11s %P\0' |
  LC_ALL=C sort -z |
  uniq -Dzw11 |
  while IFS= read -r -d '' line
  do
    md5sum "${line:12}"
  done |
  uniq -w32 --all-repeated=separate |
  tee duplicated.log
