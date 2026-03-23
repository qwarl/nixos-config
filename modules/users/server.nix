{ info,...}:{
  home = {
    homeDirectory = "/home/${(builtins.elemAt info.users 4).name}";
    stateVersion = info.stateVersion;
    username = (builtins.elemAt info.users 4).name;

  };

}
