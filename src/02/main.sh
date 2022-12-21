#!/bin/bash

source ./lib.sh || (2>&1 echo "Library not found. Are you running script in correct location?" && exit 1)

info="$(collect_sys_info)"
echo "$info"
echo "Read data to file?"
read -r answer

if [[ "$answer" =~ [yY] ]]; then
	filename="$(date +"%d_%m_%y_%M_%S").status"
	echo "$info" > "$filename"
fi
