
{ lib, config, ... }:{
  options = {
    zedMod = lib.mkEnableOption "enables zedMod";
  };

  config = lib.mkIf config.zedMod {
    programs.zed-editor = {
      enable = true;
    };
  };
}
