{ pkgs, ... }:
{
  imports = [
    ../../modules/vm/home/packages.nix
    ../../modules/shared/packages
  ];
  home = {
    homeDirectory = "/home/quan";
    stateVersion = "25.05";
    username = "quan";
  };

  batMod = true;
  ezaMod = true;
  fcitx5Mod = true;
  fdMod = true;
  fontsMod = true;
  fzfMod = true;
  gitMod = true;
  neovimMod = true;
  ripgrepMod = true;
  vscodeMod = true;
  weztermMod = true;
  zoxideMod = true;
  zshMod = true;
}
