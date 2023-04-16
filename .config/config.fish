if status is-interactive
    # Commands to run in interactive sessions can go here
    # ~/.config/fish/config.fish: Fish shell configuration

# Set vi key bindings
fish_vi_key_bindings

# Set history options
set -U fish_history_ignore_space true
set -U fish_history_ignore_duplicates true
set -U fish_history_limit 1000
set -U fish_history_filesize 2000

# Check window size after each command
function fish_update_window_size
    set -g LINES (tput lines)
    set -g COLUMNS (tput cols)
end

function fish_prompt
    set -l P '$'
    set -l dir (basename (pwd))
    set -l B

    if test $USER = "root"
        set P '#'
    end

    if test $PWD = "/"
        set dir /
    end

    if test $PWD = $HOME
        set dir '~'
    end

    set B (git branch --show-current 2>/dev/null)

    # if test $dir = $B
    #     set B .
    # end

    # if test $B = "master" -o $B = "main"
    #     set B (set_color red)$B
    # end

    if test -n "$B"
        set B (set_color cyan)"("$B")"
    end

    echo -n -s (set_color yellow)$USER (set_color cyan)"@" (set_color blue)(hostname) (set_color cyan)": " (set_color white)$dir$B
    echo -n -s (set_color blue)"$P " (set_color normal)
end

# cd function
function cd
    builtin cd $argv
    exa -all
end

# --------------------- aliases ---------------------
# alias lynx 'docker run -it --rm lynx'
# alias '?' 'google'
# alias '??' 'duck'
# alias '???' 'bing'
# alias vi 'vim'
# alias v 'v.sh'
# alias got 'go test'
# alias gor 'go run'
# alias gob 'go build'
# alias ga 'git add'
# alias commit 'git commit'
alias reload 'exec fish -l'
alias pwc 'pwd | pbcopy'
alias exa 'exa -all'
#alias elixir 'docker run -it --rm elixir'


# Custom functions
function mkdircd
    mkdir -p $argv
    cd $argv
end

function open-ports
    lsof -i -P -n | grep LISTEN
end

function gi
    curl -sL "https://www.toptal.com/developers/gitignore/api/$argv"
end

function cpu-temp
    sudo powermetrics --samplers smc | grep -i "CPU die temperature"
end

# Environment variables
set -xU GHPATH "$HOME/repos/github.com/brailor"
set -xU CDPATH ".:$GHPATH:$HOME"
set -xU GOPATH "$HOME/go"
set -xU PATH $HOME/local/bin $HOME/scripts $HOME/repos/github.com/other/lynx/bin $HOME/go/bin $HOME/bin $HOME/node_modules/.bin $PATH
set -xU EDITOR nvim
set -xU VISUAL nvim

set -xU NVM_DIR "$HOME/.config/nvm"


set -xU DENO_INSTALL "/Users/viktor.ohad/.deno"
set -xU BUN_INSTALL "/Users/viktor.ohad/.bun"
set -xU PATH "$BUN_INSTALL/bin" "$DENO_INSTALL/bin" "/path/to/elixir/bin" "/nix" "/opt/homebrew/bin" $PATH


# Tabtab source for packages
# if test -f ~/.config/tabtab/fish/__tabtab.fish
#     . ~/.config/tabtab/fish/__tabtab.fish
# end

# Rust cargo
# . "$HOME/.cargo/env"

set -xU FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# McFly
set -xU MCFLY_KEY_SCHEME vim
# eval (mcfly init fish)

# TheFuck
# eval (thefuck --alias)

# FZF
if test -f ~/.fzf.fish
    source ~/.fzf.fish
end


end
