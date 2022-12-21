#!/bin/bash

if ! source ../02/lib.sh; then
	2>&1 echo "Library not found. Are you running script in correct location?"
	exit 1
fi

declare -A font_col=(
	[0]="\033[0m" # clear color
	["1"]="\033[37m" # white
	["2"]="\033[31m" # red
	["3"]="\033[32m" # green
	["4"]="\033[34m" # blue
	["5"]="\033[35m" # purple
	["6"]="\033[30m" # black
)

declare -A bg_col=(
	[0]="\033[0m" # clear color
	["1"]="\033[47m" # white
	["2"]="\033[41m" # red
	["3"]="\033[42m" # green
	["4"]="\033[44m" # blue
	["5"]="\033[45m" # purple
	["6"]="\033[40m" # black
)

# $1 - number to validate
validate_number() {
	if [[ "$1" -le 0 || "$1" -gt 6 ]]; then
		2>&1 echo "Error: color number $1 is out of range. Allowed color codes: 1..6"
		return 1
	fi
	return 0
}

if [[ "$#" != 4 ]]; then
	1>&2 echo "Incorrect number of args. Expected 4, got - $#"
	exit 1
fi

if [[ "$1" == "$2" || "$3" == "$4" ]]; then
	1>&2 echo "Error: background and font colors should not match."
	exit 1
fi

validate_number "$1" || exit 1
validate_number "$2" || exit 1
validate_number "$3" || exit 1
validate_number "$4" || exit 1


# $1 - backgroun of value names (HOSTNAME..)
# $2 - font color of value names (HOSTNAME..)
# $3 - background of values
# $4 - font color of values
collect_sys_info | awk 		\
	-v c0="${font_col[0]}" 	\
	-v c1="${bg_col[$1]}" 	\
	-v c2="${font_col[$2]}" \
	-v c3="${bg_col[$3]}" 	\
	-v c4="${font_col[$4]}" \
	'{ 
	printf(\
		"%s%s%s%s = %s%s%s%s\n",
		c1, c2,
		$1, c0,
		c3, c4,
		$3, c0);
}'
