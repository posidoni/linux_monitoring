#!/bin/bash

function collect_sys_info() {
	hostname="$(hostname)"
	timezone="$(date +"$(head /etc/timezone) UTC %Z")"
	user="$(whoami)"
	os="$(hostnamectl | grep --color=NEVER -i -e"operating")"
	date="$(date +"%d %b %Y %R:%S")"
	uptime="$(uptime | awk -F "," '{print $1}')"
	sec_uptime="$(awk '{print $1}' /proc/uptime)"
	ip="$(ifconfig | awk '/netmask/{ print $2 }' |  head -1)"
	mask="$(ifconfig | awk '/netmask/{ print $4 }' |  head -1)"
	gateway="$(ip r | awk '/default/{ print $3 }')"
	ram_total="$(free --mega | awk 'BEGIN{IGNORECASE=1;} /mem/{ printf("%.3f GB", $2/1024) }')"
	ram_used="$(free --mega | awk 'BEGIN{IGNORECASE=1;} /mem/{ printf("%.3f GB", $4/1024) }')"
	ram_free="$(free --mega | awk 'BEGIN{IGNORECASE=1;} /mem/{ printf("%.3f GB", $5/1024) }')"
	root_total="$(df -h -BK | awk '/\s\/$/{printf("%.2f", $2/1024)}')"
	root_used="$(df -h -BK | awk '/\s\/$/{printf("%.2f", $3/1024)}')"
	root_available="$(df -h -BK | awk '/\s\/$/{printf("%.2f", $4/1024)}')"

	cat <<-EOF
	HOSTNAME = $hostname
	TIMEZONE = $timezone
	USER = $user
	OS = $os
	DATE = $date
	UPTIME = $uptime
	UPTIME_SEC = $sec_uptime
	IP = $ip
	MASK = $mask
	GATEWAY = $gateway
	RAM_TOTAL = $ram_total
	RAM_USED = $ram_used
	RAM_FREE = $ram_free
	SPACE_ROOT = $root_total
	SPACE_ROOT_USED = $root_used
	SPACE_ROOT_FREE = $root_available
	EOF
}
