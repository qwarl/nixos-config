{ pkgs, info, ... }:
{
  imports = [
    ../../modules/vm/home/packages.nix
    ../../modules/shared/home-manager/packages
  ];
  home = {
    homeDirectory = "/home/quan";
    stateVersion = info.stateVersion;
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
