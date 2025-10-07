#!/usr/bin/env nu

def generate-metadata [archive: string] {
  let $filename = ($archive | path basename)
  let $output_dir = ($filename | path parse | get stem)
  let $name = ($output_dir | parse -r 'RJ\d+_(?P<name>.+)')
  { name: $name, filename: $filename, output_dir: $output_dir }
}

def do-unzip [metadata] {
  unzip -n $metadata.filename -d $metadata.output_dir
}

def do-unzip-jp [metadata] {
  unzip-jp.py $metadata.filename
}

def apply-audio-tags [set_title: bool, album?: string, artist?: string, genre?: string] {
  let $input = $in
  cd $input.output_dir

  let $audio_files = (ls **/*
    | where ($it.name | path parse | get extension) == mp3
        or ($it.name | path parse | get extension) == flac
        or ($it.name | path parse | get extension) == wav
    | get name)

  for $file in $audio_files {
    if ($genre != null) {
      ^kid3-cli $file -c $"set Album '($album)'"
    }
    if ($genre != null) {
      ^kid3-cli $file -c $"set Genre '($genre)'"
    }
    if ($artist != null) {
      ^kid3-cli $file -c $"set Artist '($artist)'"
    }
    if ($set_title == true) {
      let $title = ($file | path parse | get stem)
      ^kid3-cli $file -c $"set Title '($title)'"
    }
    ^kid3-cli $file -c get
  }

  null
}

def main [archive: string, --album: string, --artist: string, --genre: string, --jp, --clean, --repack, --set-title] {
  print $album

  let $parent_folder = ($archive | path parse | get parent)
  cd $parent_folder

  let $metadata = generate-metadata $archive

  if $jp {
    do-unzip-jp $metadata
  } else {
    do-unzip $metadata
  }

  $metadata | apply-audio-tags $set_title $album $artist $genre

  if $repack {
    mkdir repacked
    ^zip $"./repacked/($metadata.filename)" -r $metadata.output_dir
  }

  if $clean {
    rm -r $metadata.output_dir --trash
  }

  echo "Success!"
}
