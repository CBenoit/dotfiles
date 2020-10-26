#!/bin/bash

# requires `mediainfo` and `ffmpeg` with `loudnorm`

if [[ $# -ne 2 ]]; then
  echo "usage: normalize.sh <filepath> <target_folder>"
  exit
fi

file="$1"
folder="$2"
output="$folder/$file"

echo "normalize $file to $output"

target_i=-16
target_tp=-1.5
target_lra=11
duration_ms=$(mediainfo --Inform="Audio;%Duration%" "$file")
duration_s=$(bc <<< "scale=3; $duration_ms / 1000")
durations=(3.1 $duration_s)

IFS=$'\n'
max_duration_s=$(echo "${durations[*]}" | sort -nr | head -n1)

# We use loudnorm to perform post-process: http://k.ylo.ph/2016/04/04/loudnorm.html
eval $(ffmpeg -hide_banner -i "$file" -af apad,atrim=0:"$max_duration_s",loudnorm=I="$target_i":TP="$target_tp":LRA="$target_lra":print_format=json -f null - 2>&1 | env grep "[\"\{\}]" | python -c "import sys, json; data = json.load(sys.stdin); print(\"input_i={}\ninput_tp={}\ninput_lra={}\ninput_thresh={}\ntarget_offset={}\".format(data['input_i'], data['input_tp'], data['input_lra'], data['input_thresh'], data['target_offset']))")
ffmpeg -i "$file" -af apad,atrim=0:"$max_duration_s",loudnorm=I="$target_i":TP="$target_tp":LRA="$target_lra":measured_I="$input_i":measured_TP="$input_tp":measured_LRA="$input_lra":measured_thresh="$input_thresh":offset="$target_offset",silenceremove=start_periods=1:start_silence=0.1:start_threshold=-96dB:detection=peak,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=-96dB:detection=peak,areverse "$output" > /dev/null 2>&1

