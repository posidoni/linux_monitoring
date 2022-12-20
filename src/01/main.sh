#!/bin/bash

ERR="Invalid input"

([ $# -eq 1 ] && echo "$1" | grep -e "[^0-9]") || echo "$ERR"
