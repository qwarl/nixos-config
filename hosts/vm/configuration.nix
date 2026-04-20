{ info, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/vm/system
  ];

  system.stateVersion = info.stateVersion;
}
