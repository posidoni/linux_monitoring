#!/bin/bash

if [[ ! -a "./colorscheme.sh" ]]; then
	2>&1 echo "Colorscheme file not found"
else
	source ./colorscheme.sh
	[[ -z "$column1_background" ]] && column1_background=4 && echo "Column 1 background = defalt (blue)"
	[[ -z "$column1_font_color" ]] && column1_font_color=6 && echo "Column 2 font color = default (black)"
	[[ -z "$column2_background" ]] && column2_background=4 && echo "Column 2 background = default (blue)"
	[[ -z "$column2_font_color" ]] && column2_font_color=6 && echo "Column 2 font color = default (black)"
fi

[[ -a "../03/main.sh" ]] || ( 2>&1 echo "Script from task III not found. Are you running program from the correct location?")

../03/main.sh "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"
