#!/bin/bash

# $1 - absolute path to directory
is_absolute_path() {

	echo "$1"

	# https://regex101.com/r/JTV4Xm/1
	if ! [[ "$1" =~ ^\/.* ]]; then
		2>&1 echo "Error: path does not start with '/', so it is no absolute"
		return 1
	fi

	# https://regex101.com/r/WBHJnU/1
	if ! [[ "$1" =~ .*\/ ]]; then
		2>&1 echo "Error: provided path does not end with '/'"
		return 1
	fi

	if ! [[ -a "$1" ]]; then
		2>&1 echo "Error: provided directory does not exist"
		return 1
	fi

	return 0
}

# $1 - dir
# $2 - amount of largest
# $3 - filter args
get_top_largest_dirs_in_dir() {
	du "$1" -bb | sort -t\  -nk1 -r | awk '
		function maximize_bytes(bytes) {
			kbytes = bytes/1024
			if (int(kbytes) > 0) {
				if (int(gbytes) > 0) {
					tbytes = gbytes / 1024
					if (int(tbytes) > 0) {
						return sprintf("%d Tbytes", tbytes)
					}
					return sprintf("%d Gbytes", gbytes)
				}
				return sprintf("%d KBytes", kbytes)
			}
			return sprintf("%d Bytes", bytes)
		}

		{
			if (NR>1) { # if this is not the first match (the directory itself)
				i++;
				printf("%d - %s %s\n"), i, $2, maximize_bytes($1)
			}
		}
	' | column -t | head -"$2"
}

# $1 - in dir
# $2 - amount
get_top_executables() {
	find "$1" -type f -ls -exec md5sum {} \; | paste - - | awk '
		function maximize_bytes(bytes) {
			kbytes = bytes/1024
			if (int(kbytes) > 0) {
				if (int(gbytes) > 0) {
					tbytes = gbytes / 1024
					if (int(tbytes) > 0) {
						return sprintf("%d Tbytes", tbytes)
					}
					return sprintf("%d Gbytes", gbytes)
				}
				return sprintf("%d KBytes", kbytes)
			}
			return sprintf("%d Bytes", bytes)
		}

		{
			j++;
			printf("%d - %s, %s, %s\n", j, $11, maximize_bytes($1), $12)
		}
	' | head -"$3"
}

# $1 - in dir
# $2 - amount
get_top_files() {
	find "$1" -type f -ls -exec file -b {} \; | paste - - | awk '
		function maximize_bytes(bytes) {
			kbytes = bytes/1024
			if (int(kbytes) > 0) {
				if (int(gbytes) > 0) {
					tbytes = gbytes / 1024
					if (int(tbytes) > 0) {
						return sprintf("%d Tbytes", tbytes)
					}
					return sprintf("%d Gbytes", gbytes)
				}
				return sprintf("%d KBytes", kbytes)
			}
			return sprintf("%d Bytes", bytes)
		}

		{
			j++;
			res = sprintf("%d - %s, %s", j, $11, maximize_bytes($1))
			for (i = 12; i <= NF; i++) {
				res = res " " $i
			}
			print res
		}
	' | head -"$3"
}

# $1 - subdirectory
get_info() {
	start=$(date +%s.%N)

	_dirs="$(find "$1" -mindepth 1 -type d)"
	_files=$(find "$1" -type f)

	total_dirs=$(wc -l <<-EOF # looks very ugly, but this is actually 'correct' way without one more echo
		$_dirs
	EOF
	)

	total_files=$(wc -l <<-EOF
		$_files
	EOF
	)

	conf_files="$(find "$1" -type f -name "*.conf" | wc -l)"
	log_files="$(find "$1" -type f -name "*.log" | wc -l)"

	sym_links="$(find "$1" -type l | wc -l)"
	exe_files="$(find "$1" -type f -executable | wc -l)"

	# Text file is quite ambigious term.
	txt_files="$(find "$1" -type f -exec file {} \; | awk '/text/' | wc -l)"
	ar_files="$(find "$1" -type f -exec file {} \; | awk '/compressed|archive/' | wc -l)"

	end=$(date +%s.%N)

	time=$(echo "$end - $start" | bc)

	cat <<-END
	Total 
	Total number of folders (including all nested ones) = $total_dirs
	TOP 5 folders of maximum size arranged in descending order (path and size):
	$(get_top_largest_dirs_in_dir "$1" 5)
	Total number of files (including files in subdirs) = $total_files
	Number of:
	Configuration files (with the .conf extension) = $conf_files
	Text files = $txt_files
	Executable files = $exe_files
	Log files (with the extension .log) = $log_files
	Archive files = $ar_files
	Symbolic links = $sym_links
	TOP 10 files of maximum size arranged in descending order (path, size and type):  
	$(get_top_files "$1" 10)
	TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)  
	$(get_top_executables "$1" 10)
	Script execution time (in seconds) = $(echo -n "$time" | xargs -0 printf "%.2lf")
	END
}

[[ $# == 1 ]] && is_absolute_path "$1" && get_info "$1"
