{pkgs, info, inputs, ...}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/shared/system
    ../../modules/server/system
    inputs.sops-nix.nixosModules.sops
  ];

  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        # default = 3;
        device = "nodev";
        useOSProber = true;
        extraEntries = ''
          menuentry "UEFI Firmware Settings" --class settings {
            fwsetup
          }
        '';
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.server = {
    isNormalUser = true;
    description = "quan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wireguard-tools # Thêm công cụ để debug
  ];

  # Secrets configuration
  sops.secrets.wireguard_server_key = {
    sopsFile = ../../modules/shared/secrets.yaml;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = info.stateVersion; # Did you read the comment?

  # Enable user custom modules
  flakeMod = true;
  userCustom.modules.docker = {
    enable = true;
    users = [ "server" ];
  };
  userCustom.modules.firewall = {
    enable = true;
    allowedTCPPorts = [22 80 443 53 853];
    allowedUDPPorts = [53 853 51820]; # Mở port cho WireGuard 51820
  };
  nixLd = true;
  userCustom.modules.wireguard = {
    enable = true;
    externalInterface = "wlo2"; # Đã cập nhật từ file cũ của bạn
    privateKeyFile = "/run/secrets/wireguard_server_key"; # Khớp với sops bên trên

    # AdGuard Home của bạn sẽ tự áp dụng vì dns mặc định trỏ về 10.13.13.1
    peers = [
      {
        # Cập nhật Public Key của client vào đây
        publicKey = "F/ev8Byi3o0tFLHAFGg1WVi2aSkVwzjYfQLfIcWQzRg=";
        allowedIPs = [ "10.13.13.2/32" ];
      }
    ];
  };
}
