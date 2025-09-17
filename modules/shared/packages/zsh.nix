{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    zshMod = lib.mkEnableOption "enables zshMod";
  };

  config = lib.mkIf config.zshMod {
    home = {
      packages = with pkgs; [
        spaceship-prompt # zsh prompt
        zsh-autosuggestions
        zsh-fzf-tab
        zsh-powerlevel10k
        zsh-syntax-highlighting
      ];
      shell.enableZshIntegration = true;
    };

    programs.zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
      plugins = [
        # external plugin (3rd plugin)
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
      ];
      initContent =
        let
          zshConfig = lib.mkOrder 1000 ''
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
                cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
                export | unset) fzf --preview "eval 'echo $'{}" "$@" ;;
                ssh) fzf --preview 'dig {}' "$@" ;;
                *) fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
                esac
            }

            # xoa yy() cua yazi tu sinh
            unset -f yy 2>/dev/null

            # tao lai alias moi
            function y() {
                local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
                yazi "$@" --cwd-file="$tmp"
                if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                    builtin cd -- "$cwd"
                fi
                rm -f -- "$tmp"
            }

            # alias nixos-rebuild function
            rebuild() {
                if [[ -z "$1" ]]; then
                    echo "Usage: rebuild <host>"
                    return 1
                fi
                sudo nixos-rebuild switch --flake /mnt/common/nixos#$1
            }

            # Update flake and rebuild system
            update() {
              if [[ -z "$1" ]]; then
                echo "Usage: update system <host>"
                return 1
              fi

              sudo nix flake update --flake /mnt/common/nixos
              sudo nixos-rebuild switch --flake /mnt/common/nixos#$1
            }

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

            # alias-finder omz plugin
            zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
            zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
            zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
            zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

            # load spaceship prompt theme
            source ${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme;

            # change from ** to 00
            export FZF_COMPLETION_TRIGGER='00'

            # init zoxicde
            # eval "$(zoxide init zsh)"
          '';
        in
        lib.mkMerge [ zshConfig ];
      oh-my-zsh = {
        enable = true;
        # official plugins of oh-my-zsh
        plugins = [
          "aliases"
          "alias-finder"
          "copybuffer" # ctrl o to copy current text in command line into clipboard
          "copyfile"
          "copypath"
          "extract"
          "gh"
          "git"
          "sudo"
          "tmux"
        ];
      };
    };
  };
}
