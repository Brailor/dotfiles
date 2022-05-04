#!/bin/bash

# $1 - will be the project's path
# create a new tmux window and autmatically cd into path
# the project should contain a bootstrap.js file, run it with node
# once done remove the tmux window and notify about the result of the bootstrap

path="$1"
branchname="$(basename $(pwd))"
windowname="build-$branchname"

if ! tmux has-session -t "main:$windowname" 2>/dev/null; then
    tmux new-window -d -c "$1" -n "$windowname" "sh bootstrap-instui.sh $branchname"
    tmux set-option -t "$windowname" remain-on-exit on
fi

