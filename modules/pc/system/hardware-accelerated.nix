{ pkgs, lib, config, ... }:{

  options = {
    hardwareAccelerated = lib.mkEnableOption "enables hardware accelerated GPU";
  };

  config = lib.mkIf config.hardwareAccelerated {
    # Enable hardware accelerated gpu
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr
    ];
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  };
}
