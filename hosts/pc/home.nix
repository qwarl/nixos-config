{
  imports = [
    ../../modules/pc/home/packages.nix
    ../../modules/shared/packages
    ../../modules/de-wm/kde/plasma-manager.nix
  ];
  home = {
    homeDirectory = "/home/kde";
    stateVersion = "25.05";
    username = "kde";
  };

  # batMod = true;
  # ezaMod = true;
  # fcitx5Mod = true;
  # fdMod = true;
  # fontsMod = true;
  # fzfMod = true;
  # gitMod = true;
  # neovimMod = true;
  # ripgrepMod = true;
  # vscodeMod = true;
  # weztermMod = true;
  # zoxideMod = true;
  # zshMod = true;
}
