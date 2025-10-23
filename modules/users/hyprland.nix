{ pkgs, info, ... }:
{
  imports = [ ../de-wm/hyprland ];
  home = {
    homeDirectory = "/home/${(builtins.elemAt info.users 0).name}";
    stateVersion = info.stateVersion;
    username = (builtins.elemAt info.users 0).name;


  };


}
