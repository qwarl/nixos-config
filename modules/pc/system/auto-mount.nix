{ lib, config, ... }:
{

  options = {
    autoMountDrives = lib.mkEnableOption "enables automatic mounting of external drives";
  };

  config = lib.mkIf config.autoMountDrives {
    # Mount external drives automatically
    fileSystems."/mnt/common" = {
      device = "/dev/disk/by-uuid/712CC9052F07546A";
      fsType = "ntfs3";
      options = [
        "rw"
        "umask=000"
        "nofail"
        "force"
      ];
    };
  };
}
