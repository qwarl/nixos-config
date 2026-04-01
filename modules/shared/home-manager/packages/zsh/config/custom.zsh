# fzf with fd
_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd) fzf --preview ' --tree --color=always {} | head -200' "$@" ;;
        export | unset) fzf --preview "eval 'echo $'{}" "$@" ;;
        ssh) fzf --preview 'dig {}' "$@" ;;
        *) fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
    esac
}

# reload waybar config
alias waybarrl="pkill -USR2 waybar"

# alias-finder omz plugin
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

# change from ** to 00
export FZF_COMPLETION_TRIGGER='00'

# --------------- rebuild and update nix ---------------
rebuild() {
    if [[ -z "$1" ]]; then
        echo "Usage: rebuild <host>"
        return 1
    fi

    sudo nixos-rebuild switch --flake "$FLAKE_PATH#$1"
}

update() {
    if [[ -z "$1" ]]; then
        echo "Usage: update <host>"
        return 1
    fi

    sudo nix flake update --flake "$FLAKE_PATH"
    sudo nixos-rebuild switch --flake "$FLAKE_PATH#$1"
}

# --------------- clean build ------------
# Delete old system generations, keep the latest N
clean_build() {
    if [[ -z "$1" ]]; then
        echo "Usage: clean_build <number_of_generations_to_keep>"
        return 1
    fi

    local keep=$1
    echo "Deleting old generations, keeping the latest $keep..."
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +$keep
    sudo nix-collect-garbage -d
}

# init zoxicde
eval "$(zoxide init zsh)"
