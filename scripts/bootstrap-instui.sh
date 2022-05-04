#!/bin/bash

branchname="$1"
# if branch is v6 we have to set node version to some very old version

start_t="$(date +%s)"

# use the version from .nvmrc
# nvm use - this is not working for some reason nvm is not found in the shell

# check whether we are in a clean state
is_dirty_branch="$(git status --porcelain)"

# check if there is available commits on remote
if [[ -z "$is_dirty_branch" ]]
then
    # this is not good, because branch name is really the worktree name, not necessarily the branches name
    git pull origin "$1"

    yarn

    yarn bootstrap

    end_t="$(date +%s)"

    diff=$((end_t - start_t))

    osascript -e "display notification \"Bootstrap for branch: $branchname is completed in: ${diff} seconds!\" with title \"Bootstrap completed!\""
fi


