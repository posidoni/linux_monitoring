#!/bin/bash

declare -A font_col=(
	["1"]="white" # white
	["2"]="red" # red
	["3"]="green" # green
	["4"]="blue" # blue
	["5"]="purple" # purple
	["6"]="black" # black
)

declare -A bg_col=(
	["1"]="white" # white
	["2"]="red" # red
	["3"]="green" # green
	["4"]="blue" # blue
	["5"]="purple" # purple
	["6"]="black" # black
)

if [[ ! -a "./colorscheme.sh" ]]; then
	2>&1 echo "Colorscheme file not found"
else
	if ! source ./colorscheme.sh; then
		echo "[!] Colorscheme not found. Falling back to default configs."
	fi
	[[ -z "$column1_background" ]] && column1_background=4 && echo "[!] Column 1 background = defalt (blue)"
	[[ -z "$column1_font_color" ]] && column1_font_color=6 && echo "[!] Column 2 font color = default (black)"
	[[ -z "$column2_background" ]] && column2_background=4 && echo "[!] Column 2 background = default (blue)"
	[[ -z "$column2_font_color" ]] && column2_font_color=6 && echo "[!] Column 2 font color = default (black)"
fi

[[ -a "../03/main.sh" ]] || ( 2>&1 echo "Script from task III not found. Are you running program from the correct location?")

../03/main.sh "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color" && \
	cat <<-EOF

	Column 1 background = $column1_background (${bg_col[$column1_background]})
	Column 1 font color = $column1_font_color (${font_col[$column1_font_color]})
	Column 2 background = $column2_background (${bg_col[$column2_background]})
	Column 2 font color = $column2_font_color (${font_col[$column2_font_color]})
	EOF
