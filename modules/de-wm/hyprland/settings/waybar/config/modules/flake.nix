{
  description = "Waybar weather module env";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.weather = pkgs.mkShell {
      packages = [
        (pkgs.python313.withPackages (ps: with ps; [ requests ]))
        pkgs.cacert
      ];

      # Giúp requests tìm được CA certs khi chạy trong Waybar
      shellHook = ''
        export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
      '';
    };

    apps.${system}.weather = {
      type = "app";
      program = "${pkgs.python313.withPackages (ps: with ps; [ requests ])}/bin/python";
    };
  };
}
