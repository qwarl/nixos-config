# Llama-cpp-rocm (Local vs Nixpkgs)

Thư mục này chứa cấu hình để build `llama.cpp` trực tiếp từ source GitHub (Local Build). Hiện tại hệ thống đang được cấu hình để dùng bản chuẩn từ **Nixpkgs** cho nhẹ máy và dễ bảo trì.

---

## 🛠 CÁCH 1: Dùng bản NIXPKGS (Hiện tại đang dùng)
Đây là bản đã build sẵn từ server NixOS, có hỗ trợ ROCm. Bạn không cần làm gì thêm.

- **Ưu điểm**: Cài cực nhanh, không tốn tài nguyên build, không bao giờ bị lỗi Hash.
- **Nhược điểm**: Có thể không phải là version mới nhất trên GitHub.

---

## 🚀 CÁCH 2: Quay lại dùng bản LOCAL BUILD (Từ Source)
Nếu bạn muốn dùng bản build tối ưu riêng (ví dụ target `gfx1200`) hoặc bản GitHub cực mới:

### Bước 1: Kích hoạt Input
Mở file `flake.nix` ở gốc project, tìm và bỏ comment (uncomment) đoạn này:
```nix
llama-cpp-rocm = {
  url = "path:./pkgs/llama-cpp-rocm";
};
```

### Bước 2: Kích hoạt Overlay Addition
Mở file `overlays/additions.nix`, bỏ comment dòng này để bản local "ghi đè" lên bản của Nixpkgs:
```nix
llama-cpp-rocm = inputs.llama-cpp-rocm.packages.${final.stdenv.hostPlatform.system}.default;
```

### Bước 3: Build và Update
Chạy lệnh update của bạn:
```bash
update pc
```
Nix sẽ thấy Overlay mới và bắt đầu tải source từ GitHub về để build cho bạn.

---

## 📝 Lưu ý quan trọng
- Khi dùng **CÁCH 2**, nếu bị lỗi `hash mismatch`, hãy mở file `pkgs/llama-cpp-rocm/default.nix` và cập nhật lại `hash` hoặc `npmDepsHash` theo mã lỗi mà Nix báo (copy cái `got: sha256-...` dán vào).
- Luôn giữ file `modules/pc/home/packages.nix` có tên `llama-cpp-rocm` trong danh sách cài đặt.
