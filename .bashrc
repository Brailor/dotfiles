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
HISTCONTROL=ignoreboth:ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

PROMPT_COMMAND="${PROMPT_AT:+$PROMPT_COMMAND$'\n'} __ps1"

cd(){
  builtin cd "$@" ; ls ;
}

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
#--------------------- aliases-------------------------------------
alias lynx='docker run -it --rm lynx'
alias ?='google'
alias ??='duck'
alias ???='bing'
alias vi='vim'
alias v='v.sh'
alias got='go test'
alias gor='go run'
alias gob='go build'
alias ga='git add'
alias commit='git commit'
alias reload='exec bash -l'
#alias elixir='docker run -it --rm elixir'

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

mkdircd() {
	mkdir -p "$@" && cd "$_" || return
}

split() {
	IFS=$'\n' read -d "" -ra arr <<<"${1//$2/$'\n'}"
	printf '%s\n' "${arr[@]}"
}

open-ports() {
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



export GHPATH="${HOME}/repos/github.com/brailor"
export CDPATH=".:$GHPATH:$HOME"
export GOPATH="$HOME/go"
export PATH=$HOME/local/bin:$HOME/scripts:$HOME/repos/github.com/other/lynx/bin:$HOME/go/bin:$HOME/bin:$HOME/node_modules/.bin/:$PATH
export EDITOR=nvim
export VISUAL=nvim

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/viktor.ohad/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/viktor.ohad/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/viktor.ohad/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/viktor.ohad/Downloads/google-cloud-sdk/completion.bash.inc'; fi
export DENO_INSTALL="/Users/viktor.ohad/.deno"
export PATH="$DENO_INSTALL/bin:/path/to/elixir/bin:$PATH"

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/2.2.19/gems/vagrant-2.2.19/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true
. "$HOME/.cargo/env"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# to enable fuzzy finding for mcfly:
# export MCFLY_FUZZY=2

export MCFLY_KEY_SCHEME=vim
eval "$(mcfly init bash)"

# add auto completion to yarn
complete -C yarn-auto yarn-auto

alias luamake=/Users/viktor.ohad/repos/github.com/other/lua-language-server/3rd/luamake/luamake
