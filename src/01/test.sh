#!/bin/bash

source ../tests/assert.sh
source main.sh

assertScript 1 "$ERR" "$(./main.sh 1)"
assertScript 2 "$ERR" "$(./main.sh 0001)"
assertScript 3 "$ERR" "$(./main.sh)"
assertScript 4 "$ERR" "$(./main.sh asdf asdf)"
assertScript 5 "$ERR" "$(./main.sh 123 123)"
assertScript 6 "$ERR" "$(./main.sh 1)"
assertScript 7 "aboba" "$(./main.sh aboba)"
