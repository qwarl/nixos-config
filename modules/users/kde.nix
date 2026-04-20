{ pkgs, info, ... }:
{
  imports = [
    ../../modules/pc/home/packages.nix
    # ../../modules/de-wm/kde/plasma-manager.nix
  ];
  home = {
    homeDirectory = "/home/kde";
    stateVersion = info.stateVersion;
    username = "kde";
  };

}
