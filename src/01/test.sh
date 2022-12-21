#!/bin/bash

if ! source ../tests/assert.sh || ! source main.sh; then
	2>&1 echo "Libraries not found. Are you running script from correct location?"
	exit 1
fi

assertScript 1 "$ERR" "$(./main.sh 1)"
assertScript 2 "$ERR" "$(./main.sh 0001)"
assertScript 3 "$ERR" "$(./main.sh)"
assertScript 4 "$ERR" "$(./main.sh asdf asdf)"
assertScript 5 "$ERR" "$(./main.sh 123 123)"
assertScript 6 "$ERR" "$(./main.sh 1)"
assertScript 7 "aboba" "$(./main.sh aboba)"
