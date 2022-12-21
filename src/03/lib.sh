#!/bin/bash

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

export font_col
export bg_col
