{ lib, config, pkgs, ... }:

let
  cfg = config.userCustom.modules.wireguard;
in
{
  options.userCustom.modules.wireguard = {
    enable = lib.mkEnableOption "Enable WireGuard VPN server";

    ips = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "10.13.13.1/24" ];
      description = "Internal IP addresses for the wg0 interface";
    };

    subnet = lib.mkOption {
      type = lib.types.str;
      default = "10.13.13.0/24";
      description = "The subnet used for NAT (should match the ips range)";
    };

    listenPort = lib.mkOption {
      type = lib.types.int;
      default = 51820;
      description = "UDP port to listen for incoming VPN connections";
    };

    externalInterface = lib.mkOption {
      type = lib.types.str;
      description = "The network interface that connects to the internet (e.g., eth0, enp1s0)";
      example = "eth0"; # ip route show default | awk '/default/ {print $5}'
    };

    privateKeyFile = lib.mkOption {
      type = lib.types.str;
      description = "Path to the private key file (e.g., from sops-nix)";
    };

    dns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "10.13.13.1" ]; # Trỏ về IP của Server để dùng AdGuard Home
      description = "DNS servers for clients";
    };

    peers = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            publicKey = lib.mkOption { type = lib.types.str; };
            allowedIPs = lib.mkOption { type = lib.types.listOf lib.types.str; };
          };
        }
      );
      default = [ ];
      description = "List of VPN clients (peers)";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    networking.wireguard.interfaces.wg0 = {
      ips = cfg.ips;
      listenPort = cfg.listenPort;
      privateKeyFile = cfg.privateKeyFile;

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${cfg.subnet} -o ${cfg.externalInterface} -j MASQUERADE
      '';
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${cfg.subnet} -o ${cfg.externalInterface} -j MASQUERADE
      '';

      peers = cfg.peers;
    };
  };
}
