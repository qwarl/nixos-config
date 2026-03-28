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
# convert env → array
users=("${(@s: :)USERS}")
paths=("${(@s: :)CONFIG_PATHS}")

get_flake_path() {
  local target="$1"

  for (( i=1; i<=${#users[@]}; i++ )); do
    if [[ "${users[$i]}" == "$target" ]]; then
      local nix_index=$((i - 1))

      if (( nix_index <= 3 )); then
        echo "${paths[1]}"
      else
        echo "${paths[2]}"
      fi
      return 0
    fi
  done

  echo "User not found: $target"
  return 1
}

rebuild() {
  if [[ -z "$1" ]]; then
    echo "Usage: rebuild <host>"
    return 1
  fi

  local flake_path
  flake_path=$(get_flake_path "$1") || return 1

  sudo nixos-rebuild switch --flake "$flake_path#$1"
}

update() {
  if [[ -z "$1" ]]; then
    echo "Usage: update <host>"
    return 1
  fi

  local flake_path
  flake_path=$(get_flake_path "$1") || return 1

  sudo nix flake update --flake "$flake_path"
  sudo nixos-rebuild switch --flake "$flake_path#$1"
}

# init zoxicde
eval "$(zoxide init zsh)"