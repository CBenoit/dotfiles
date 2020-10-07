hash=$1
file=$2
line=$3
column=$4

from=$(( line - 20 ))
from=$(( from > 0 ? from : 0 ))

to=$(( line + 20 ))

echo "${file}"

if [[ $(echo "${file}" | grep ".\..") ]]; then
	extension="${file##*.}"
	git show ${hash}:${file} | bat --color=always -l ${extension} -H ${line} --theme gruvbox --line-range ${from}:${to}
else
	git show ${hash}:${file} | bat --color=always -H ${line} --theme gruvbox --line-range ${from}:${to}
fi

