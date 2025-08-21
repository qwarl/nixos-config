{
  imports = [
    ./hardware-configuration.nix
    ../../modules/vm/system
  ];

  system.stateVersion = "25.05";
}
