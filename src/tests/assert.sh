#!/bin/bash

# $1 - test N
# $2 - expected
# $3 - program output
assertScript() {
	if [[ -z "$3" ]] || [[ "$2" != "$3" ]]; then
		echo -e "Error, got $2, expected $3\n"
	else
		echo -e "Test $1 - OK"
	fi
}
