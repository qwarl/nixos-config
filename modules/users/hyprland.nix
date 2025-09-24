{ pkgs, ... }:
{
  imports = [ ../de-wm/hyprland ];
  home = {
    homeDirectory = "/home/hyprland";
    stateVersion = "25.05";
    username = "hyprland";

    packages = with pkgs; [
      grim
      hyprshot
      kdePackages.dolphin
      slurp
      wf-recorder
      xdg-user-dirs
      xdg-utils
    ];
  };

}
