#!/bin/bash

# curl cht.sh/{lang}/query
# curl cht.sh/{core-util}-{operation}

languages="go nodejs typescript javascript python bash"
core_utils="awk sed grep cut tr"
all="$languages $core_utils"

selected="$(echo -e "${all// /\\n}" | fzf)"

read -rp "query: " query

open-tmux() {
        tmux new-window -n "cht.sh - $selected"  bash -c "$1"
}

if printf "$languages" | grep -qs "$selected" ; then
    query_uri="$selected/$(echo "$query" | tr ' ' '+')"
    open-tmux "curl -s cht.sh/$query_uri | less -R"
else
    open-tmux "curl -s  cht.sh/$selected~$query | less -R"
fi

