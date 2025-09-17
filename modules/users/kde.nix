{ pkgs, ... }:
{
  imports = [
    ../../modules/pc/home/packages.nix
    ../../modules/de-wm/kde/plasma-manager.nix
  ];
  home = {
    homeDirectory = "/home/kde";
    stateVersion = "25.05";
    username = "kde";
  };

}
