#!/usr/bin/env nu

def generate-metadata [archive: string] {
  let $filename = ($archive | path basename)
  let $output-dir = ($filename | path parse | get stem)
  let $name = ($output-dir | parse -r 'RJ\d+_(?P<name>.+)')
  { name: $name, filename: $filename, output-dir: $output-dir }
}

def do-unzip [metadata] {
  unzip -n $metadata.filename -d $metadata.output-dir
}

def do-unzip-jp [metadata] {
  unzip-jp.py $metadata.filename
}

def apply-audio-tags [album?: string, artist?: string, genre?: string] {
  let $input = $in
  cd $input.output-dir

  let $audio-files = (ls **/*
    | where ($it.name | path parse | get extension) == mp3
        || ($it.name | path parse | get extension) == flac
        || ($it.name | path parse | get extension) == wav
    | get name)

  for $file in $audio-files {
    if ($genre != null) {
      ^kid3-cli $file -c $"set Album '($album)'"
    }
    if ($genre != null) {
      ^kid3-cli $file -c $"set Genre '($genre)'"
    }
    if ($artist != null) {
      ^kid3-cli $file -c $"set Artist '($artist)'"
    }
    ^kid3-cli $file -c get
  }

  null
}

def main [archive: string, --album: string, --artist: string, --genre: string, --jp, --clean, --repack] {
  print $album

  let $parent-folder = ($archive | path parse | get parent)
  cd $parent-folder

  let $metadata = generate-metadata $archive

  if $jp {
    do-unzip-jp $metadata
  } else {
    do-unzip $metadata
  }

  $metadata | apply-audio-tags $album $artist $genre

  if $repack {
    mkdir repacked
    ^zip $"./repacked/($metadata.filename)" -r $metadata.output-dir
  }

  if $clean {
    rm -r $metadata.output-dir --trash
  }

  echo "Success!"
}
