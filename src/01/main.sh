#!/bin/bash

ERR="Invalid input"

{ [[ $# -eq 1 ]] && [[ ! "$1" =~ [+-]*[0-9\.]*|[+-]*[0-9]*[eE][-+][0-9]* ]]; } || echo "$ERR"
