{ inputs, ... }:
final: prev: {
  # Ví dụ: sửa bản nixd mặc định
  # nixd = prev.nixd.overrideAttrs (old: { ... });

  # Đây là nơi bạn sửa các package ĐÃ CÓ SẴN trong nixpkgs
}
