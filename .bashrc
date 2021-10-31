# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more optisons
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PROMPT_AT=@

#TODO: clean up this func a bit
#play with colors more
__ps1() {
	local P='$' dir="${PWD##*/}" B \
		r='\[\e[31m\]' g='\[\e[36m\]' h='\[\e[34m\]' \
		u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[97m\]' \
		b='\[\e[36m\]' x='\[\e[0m\]'

	[[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
	[[ $PWD = / ]] && dir=/
	[[ $PWD = "$HOME" ]] && dir='~'

	B=$(git branch --show-current 2>/dev/null)
	[[ $dir = "$B" ]] && B=.

	[[ $B = master || $B = main ]] && b="$r"
	[[ -n "$B" ]] && B="$g($b$B$g)"

	PS1="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$p$P$x "
}

PROMPT_COMMAND="__ps1"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

alias lynx='docker run -it --rm lynx '
alias ?='google'
alias ??='duck'
alias ???='bing'
alias vi='vim'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls -1 --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# alias pbcopy='xdc-copi'
	alias open='xdg-open'
elif [[ "$OSTYPE" == "darwin"* ]]; then
	#
	alias
elif [[ "$OSTYPE" == "cygwin" ]]; then
	# add windows specific aliases
	alias
else
	echo "Unknown OS"
fi
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

function mkdircd() {
	mkdir -p "$@" && cd "$_" || return
}

function split() {
	IFS=$'\n' read -d "" -ra arr <<<"${1//$2/$'\n'}"
	printf '%s\n' "${arr[@]}"
}

function open-ports() {
	lsof -i -P -n | grep LISTEN
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
# if type brew &>/dev/null
# then
#   HOMEBREW_PREFIX="$(brew --prefix)"
#   if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
#   then
#      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
#   else
#      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
#      do
#       [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
#      done
#   fi
# fi

export PATH=~/scripts:$HOME/repos/github.com/other/lynx/bin:$HOME/bin:$HOME/node_modules/.bin/:$PATH

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/viktor.ohad/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/viktor.ohad/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/viktor.ohad/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/viktor.ohad/Downloads/google-cloud-sdk/completion.bash.inc'; fi
