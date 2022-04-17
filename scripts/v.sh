#!/bin/bash

if [[ "$#" == 0 ]]; then
	if [[ -z "$(command -v fzf)" ]]; then
		echo "The program fzf is required for this script to work!"
		exit
	fi
	path_to_file="$(fzf)"

	if [[ -z "$path_to_file" ]]; then
		exit
	fi
	# TODO; investigate how to do this:
	#cd "$(dirname "$path_to_file")" || echo "cd failed to $(dirname path_to_file)" && exit
	nvim "$path_to_file"
else
	nvim "$@"
fi

