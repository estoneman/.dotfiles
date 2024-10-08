# .bash_aliases

# helpful ls
alias ls='ls --color=auto'
alias la='ls -lAF'
alias l='ls -lhF'
alias ll='ls -lhF'
alias lt='ls -lhFt'
alias li='ls -lihF'
alias lsz='ls -lShF'

# safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# common
alias cat='bat'
alias htop='htop -d 12' # -d (delay) is measured in tenths of a second
alias tmnew='tmux new -s'
alias vi='nvim'
alias vim='nvim'

# zoxide
alias cd='z'

# kubernetes
alias k='kubectl'

docker_tags() {
	if [ -z "$1" ]; then
		cat <<HELP
show tags of a docker hub repository

usage:

    $ docker_tags <repository> [page_size(default: 100)]

example:

    $ docker_tags debian 50 # shows the next 50 tags of the debian repository
    1.1.1
    alpine
    1.11.9
    ...
HELP
		return;
	fi
	curl -sS "https://hub.docker.com/v2/namespaces/library/repositories/$1/tags?page_size=${2:-100}" | \
		jq -r '.results[].name'
}

mkcd() {
    mkdir -p "$@" && cd "$_" || return
}

ping_check() {
    while ! ping -c 1 -W 3 "$1"; do
        sleep 1
        clear
    done
}

source_venv() {
    local _venv_base

    _venv_base="$HOME/.local/pipx/venvs" 

    if [ -z "$1" ]; then
        echo 'usage: source_venv <venv>' && return
    elif ! [ -d "$_venv_base/$1" ]; then
        echo "$1 does not exist" && return
    fi

    # shellcheck disable=SC1091,1090
    source "$HOME/.local/pipx/venvs/$1/bin/activate"
}

tmnewn() {
	if [ -z "$1" ]; then
		tmnew "${PWD##*/}" && return
	fi

	tmnew "$1"
}
