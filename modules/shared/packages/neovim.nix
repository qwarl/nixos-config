{ lib, config, ... }:
let
  neovimRepo = builtins.fetchGit {
    url = "https://github.com/qwarl/nvim.git";
    ref = "nuke";
    rev = "bd83d9a49a265800c699bb38a5421dc2f43e2487";
  };
  neovimLua = builtins.readFile "${neovimRepo}/neovim.lua";
in
{

  options = {
    neovimMod = lib.mkEnableOption "enables neovimMod";
  };

  config = lib.mkIf config.neovimMod {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      # extraLuaConfig = neovimLua;
    };
    home.file.".config/nvim".source = neovimRepo;
  };
}
