{ lib, config, ... }:
{

  options = {
    vscodeMod = lib.mkEnableOption "enables vscodeMod";
  };

  config = lib.mkIf config.vscodeMod {
    programs.vscode = {
      enable = true;
      profiles = {
        default = {
          userSettings = {
            "editor.fontFamily" = "CaskaydiaMono Nerd Font";
            "workbench.sideBar.location" = "right";
            "files.autoSave" = "onWindowChange";
            "terminal.integrated.env.linux" = { };
          };
        };
      };
    };
  };
}
