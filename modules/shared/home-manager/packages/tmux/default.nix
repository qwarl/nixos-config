{lib, config, pkgs, ...}:
{

  options = {
    tmuxMod = lib.mkEnableOption "enables tmuxMod";
  };

  config = lib.mkIf config.tmuxMod {
    home.packages = with pkgs; [
      tmux
    ];
    xdg.configFile."tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/server/nixos-config/modules/shared/home-manager/packages/tmux/config/tmux.conf";
  };

}
