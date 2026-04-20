{ inputs, ... }: {
  # Overlay này thêm các package mới vào pkgs
  additions = import ./additions.nix { inherit inputs; };

  # Overlay này dùng để sửa đổi (override) các package đã có sẵn trong nixpkgs
  modifications = import ./modifications.nix { inherit inputs; };
}
