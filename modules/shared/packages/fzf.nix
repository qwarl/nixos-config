{ lib, config, ... }:
{

  options = {
    fzfMod = lib.mkEnableOption "enables fzfMod";
  };

  config = lib.mkIf config.fzfMod {
    programs.fzf = {
      enable = true;
      # alt c
      # already include hidden and exclude .git in fd.nix
      changeDirWidgetCommand = "fd --type d --strip-cwd-prefix --follow";
      changeDirWidgetOptions = [ "--preview '~/Documents/bin/fzf-preview-image.sh {}'" ];
      # default fzf
      defaultCommand = "fd --follow --strip-cwd-prefix --follow";
      defaultOptions = [
        "--layout reverse"
        "--border"
        "--preview '~/Documents/bin/fzf-preview-image.sh {}'"
      ];
      # ctrl t
      fileWidgetCommand = "fd --type f --strip-cwd-prefix --follow";
      fileWidgetOptions = [ "--preview '~/Documents/bin/fzf-preview-image.sh {}'" ];
    };
  };
}
