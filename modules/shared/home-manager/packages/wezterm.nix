{ lib, config, inputs, ... }:
let
  weztermLua = builtins.readFile "${inputs.wezterm-config}/wezterm.lua";
in
{
  options = {
    weztermMod = lib.mkEnableOption "enables weztermMod";
  };

  config = lib.mkIf config.weztermMod {
    programs.wezterm = {
      enable = true;
      extraConfig = weztermLua;
    };
  };
}
