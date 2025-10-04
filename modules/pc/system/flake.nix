{ lib, config, ... }:
{

  options = {
    flakeMod = lib.mkEnableOption "enables flakeMod";
  };

  config = lib.mkIf config.flakeMod {
    # Enable flake config
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
