{ lib, config, ... }:{

  options = {
    nixLd = lib.mkEnableOption "enables Nix LD for running unpatched dynamic binaries";
  };

  config = lib.mkIf config.nixLd {
    # Run unpatched dynamic binaries on NixOS. (binaries mason.nvim installed)
    programs.nix-ld.enable = true;
  };
}
