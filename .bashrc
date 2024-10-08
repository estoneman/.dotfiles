# .bashrc

load_order=(env env.osx aliases aliases.osx completion options)
rc_d="$HOME/.dotfiles/.bashrc.d"

if [ -d "$rc_d" ]; then
    for rc in "${load_order[@]}"; do
        # shellcheck disable=SC1090
        . "$rc_d/.bash_$rc"
    done
fi
