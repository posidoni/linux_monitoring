#!/bin/bash

source ./lib.sh

info="$(collect_sys_info)"
echo "$info"
echo "Read data to file?"
read -r answer

if [[ "$answer" =~ [yY] ]]; then
	filename="$(date +"%d_%m_%y_%M_%S").status"
	echo "$info" > "$filename"
fi
