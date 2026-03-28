{
  pkgs,
  lib,
  config,
  info,
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
      sessionVariables = {
        USERS = builtins.concatStringsSep " " (map (u: u.name) info.users);
        CONFIG_PATHS = builtins.concatStringsSep " " (map (u: u.path) info.configPaths);
      };
      initContent =
        let
          zshConfig = lib.mkOrder 1000 ''
            source /home/server/nixos-config/modules/shared/home-manager/packages/zsh/config/custom.zsh

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

            # load spaceship prompt theme
            source ${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme;
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
 # home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/server/nixos-config/modules/shared/home-manager/pakcages/zsh/config/.zshrc";
  };
}
