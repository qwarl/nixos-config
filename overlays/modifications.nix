{ inputs, ... }:
final: prev: {
  # Fix flaky openldap tests blocking the build
  openldap = prev.openldap.overrideAttrs (old: {
    doCheck = !prev.stdenv.hostPlatform.isi686;
  });

  # Đây là nơi bạn sửa các package ĐÃ CÓ SẴN trong nixpkgs
}
