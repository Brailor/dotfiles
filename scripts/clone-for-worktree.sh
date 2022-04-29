#!/bin/bash

# use cases for git clone that this script have to handle:
#  - git clone git@github.com:<user/org>/<reponame>.git -> will create dir with the reponame
#  - git cline git@github.com:<user/org>/<reponame>.git clonedir -> will create clonedir and put the repo contents in it
# usage:
# clone-for-worktree url [dir]

set -e

if [[ -z "$1" ]]
then
    echo "usage: clone-for-worktree url [dir]" && exit 1
fi

url="$1"
repo_with_ext="${url##*/}"
dir=""

if [[ -z "$2" ]]
then
    dir="${repo_with_ext%*.git}"
else
    dir="$2"
fi

# clone the repo as a bare repo
git clone --bare "$url" "$dir"

cd "$dir"

# modify fetch config
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# fetch all branches from remote
git fetch origin
