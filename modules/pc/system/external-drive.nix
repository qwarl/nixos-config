{
  # Enable udisks2 for removable media
  services.udisks2.enable = true;
  services.gvfs.enable = true; # adds support for MTP (Android phones), SMB/FTP/SFTP, Google Drive, etc.
  services.devmon.enable = true; # auto-mounts hotplug devices (USB, external drives) without needing to click "Mount"
}
