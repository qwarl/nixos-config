{ pkgs, info, ... }:
{
  imports = [ ../de-wm/hyprland ];
  home = {
    homeDirectory = "/home/${(builtins.elemAt info.users 0).name}";
    stateVersion = info.stateVersion;
    username = (builtins.elemAt info.users 0).name;

    packages = with pkgs; [
      grim
      hyprshot
      kdePackages.dolphin
      rofi
      slurp
      wf-recorder
      xdg-user-dirs
      xdg-utils

      kdePackages.polkit-kde-agent-1
    ];
  };

  hyprpanelMod = true;

}
