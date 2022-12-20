#!/bin/bash

# **SPACE_ROOT** = _root partition size in MB, with an accuracy of two decimal places, as **254.25 MB**_  
# **SPACE_ROOT_USED** = _size of used space of the root partition in MB, with an accuracy of two decimal places_  
# **SPACE_ROOT_FREE** = _size of free space of the root partition in MB, with an accuracy of two decimal places_

function collect_sys_info() {
	hostname="$(hostname)"
	timezone="$(date +"$(head /etc/timezone) UTC %Z")"
	user="$(whoami)"
	os="$(hostnamectl | grep --color=NEVER -i -e"operating")"
	date="$(date +"%d %b %Y %R:%S")"
	uptime="$(uptime)"
	sec_uptime="$(awk '{print $1}' /proc/uptime)"
	ip="$(ifconfig | awk '/netmask/{ print $2 }' |  head -1)"
	mask="$(ifconfig | awk '/netmask/{ print $4 }' |  head -1)"
	gateway="$(ip r | awk '/default/{ print $3 }')"
	ram_total="$(free --mega | awk 'BEGIN{IGNORECASE=1;} /mem/{ printf("%.3f GB", $2/1024) }')"
	ram_used="$(free --mega | awk 'BEGIN{IGNORECASE=1;} /mem/{ printf("%.3f GB", $4/1024) }')"
	ram_free="$(free --mega | awk 'BEGIN{IGNORECASE=1;} /mem/{ printf("%.3f GB", $5/1024) }')"
	# df -h -BK | awk '/\s\/$/{print $0}'
}

function write_sys_info_to_file() {
	echo "1"
}

