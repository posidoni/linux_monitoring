#!/bin/bash

source ../02/lib.sh
source lib.sh

if [[ "$#" != 4 ]]; then
	>&2 echo "Incorrect number of args. Expected 4, got - $#"
	exit 1
fi

if [[ "$1" == "$2" || "$3" == "$4" ]]; then
	>&2 echo "Error: background and font colors should not match."
	exit 1
fi

# $1 - backgroun of value names (HOSTNAME..)
# $2 - font color of value names (HOSTNAME..)
# $3 - background of values
# $4 - font color of values
collect_sys_info | awk 		\
	-v c0="${font_col[0]}" 	\
	-v c1="${font_col[$1]}" \
	-v c2="${bg_col[$2]}" 	\
	-v c3="${font_col[$3]}" \
	-v c4="${bg_col[$4]}" 	\
	'{ 
	printf(\
		"%s%s%s%s = %s%s%s%s\n",
		c1, c2,
		$1, c0,
		c3, c4,
		$3, c0);
}'
