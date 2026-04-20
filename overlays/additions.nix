{ inputs, ... }:
final: _prev: {
  llama-cpp-rocm = inputs.llama-cpp-rocm.packages.${final.system}.default;
  
  # Thêm các package mới của bạn vào đây
}
