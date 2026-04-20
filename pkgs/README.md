# Hướng dẫn tạo Package tùy chỉnh (Local Flake)

Tài liệu này hướng dẫn cách tạo và quản lý các package tự build hoặc override một cách chuyên nghiệp.

---

## 1. Cấu trúc thư mục "Chuyên nghiệp"

```text
/mnt/common/nixos/
├── pkgs/
│   └── <tên-package>/
│       ├── default.nix   # Logic build (Derivation)
│       └── flake.nix     # Đóng gói thành Flake độc lập
├── overlays/
│   ├── additions.nix     # CHỈ thêm package MỚI
│   ├── modifications.nix # CHỈ sửa package CÓ SẴN (override)
│   └── default.nix       # Điều phối các overlays
└── flake.nix             # Khai báo input
```

---

## 2. Bí kíp tìm Dependency (Không cần AI)

Khi bạn muốn build hoặc override một package, câu hỏi lớn nhất là: **"Nó cần cái gì?"**.

### Cách 1: Xem "công thức" gốc trên Nixpkgs (Nhanh nhất)
Nixpkgs là một kho chứa hàng triệu công thức build. Bạn chỉ cần xem họ làm thế nào:
*   **Lệnh:** `nix edit nixpkgs#llama-cpp` (Mở file nguồn của Nixpkgs lên xem).
*   **Web:** Lên [search.nixos.org](https://search.nixos.org/packages), gõ tên package -> bấm vào nút **"Source"** bên phải -> Nó sẽ dẫn bạn tới file `.nix` trên GitHub.
*   **Tìm cái gì?** Tìm mục `nativeBuildInputs` (các công cụ để build như `cmake`, `gcc`) và `buildInputs` (các thư viện đi kèm như `libGL`, `boost`).

### Cách 2: Tìm tên chính xác của Package trong Nix (REPL)
Nếu bạn không chắc package đó trong Nix gọi là gì:
1.  Gõ `nix repl -f '<nixpkgs>'` (Mở môi trường tương tác).
2.  Gõ `pkgs.vs` rồi nhấn **Tab**. Nó sẽ liệt kê tất cả các tên bắt đầu bằng `vs` (ví dụ: `vscode`, `vscodium`).

### Cách 3: Tìm xem file nào thuộc về package nào
Nếu khi build nó báo thiếu file `libGL.so`, hãy gõ:
```bash
nix-locate libGL.so
```
(Lệnh này yêu cầu bạn cài `nix-index` trước đó).

### Cách 4: Các công cụ hỗ trợ "Thần thánh"
*   **`nix-init` (Tự động hóa):** Chỉ cần đưa link GitHub, nó sẽ tự tạo file `.nix` và TỰ TÌM dependency cho bạn.
    *   Cách dùng: `nix run nixpkgs#nix-init -- https://github.com/owner/repo`
*   **`nix-tree` (Xem cây dependency):** Xem trực quan cái gì đang kéo theo cái gì.
    *   Cách dùng: `nix run nixpkgs#nix-tree -- nixpkgs#llama-cpp`

---

## 5. Tối ưu hóa cho Phần cứng (ROCm, CUDA, CPU)

Khi đối mặt với các app nặng (AI, đồ họa), đừng tự đi tìm từng dependency. Hãy dùng **Feature Flags**.

### Bước 1: "Soi" xem app đó hỗ trợ những gì
Gõ `nix edit nixpkgs#<tên-app>` (ví dụ `nix edit nixpkgs#llama-cpp`).
Tìm ở đầu file phần dấu ngoặc nhọn `{ ... }`. Bạn sẽ thấy các flag như:
*   `rocmSupport ? false` (Mặc định tắt AMD GPU)
*   `cudaSupport ? false` (Mặc định tắt NVIDIA GPU)
*   `blasSupport ? false` (Tăng tốc CPU)

### Bước 2: Chỉ lấy thứ mình cần (Lọc Dependency)
Thay vì cài bản mặc định, hãy dùng `.override` để bật đúng thứ bạn có:
```nix
(pkgs.llama-cpp.override {
  rocmSupport = true;   # Bật AMD, Nix sẽ tự kéo ROCm về
  cudaSupport = false;  # Tắt NVIDIA, Nix sẽ KHÔNG tải bất kỳ file nào của NVIDIA
  blasSupport = true;   # Tối ưu hóa cho CPU
})
```
**Lợi ích:** Bạn sẽ tiết kiệm được hàng chục GB ổ cứng và tránh được lỗi xung đột driver.

### Bước 3: Kiểm tra hệ sinh thái phần cứng trong Nix (REPL)
Nếu muốn biết AMD (ROCm) trong Nix có những thư viện nào:
1.  Gõ `nix repl -f '<nixpkgs>'`
2.  Gõ `pkgs.rocmPackages.` rồi nhấn **Tab**.
3.  Nix sẽ liệt kê toàn bộ "vũ khí" của AMD mà bạn có thể dùng.

---

## 6. Quy trình làm một Package mới (Tóm tắt)

1.  **Bước 1:** Tạo `pkgs/my-app/default.nix` (Logic build).
2.  **Bước 2:** Tạo `pkgs/my-app/flake.nix` (Đóng gói).
3.  **Bước 3:** Khai báo vào `inputs` ở `flake.nix` chính.
4.  **Bước 4:** Thêm một dòng vào `overlays/additions.nix` để đặt tên rút gọn:
    ```nix
    my-app = inputs.my-app.packages.${final.system}.default;
    ```
5.  **Bước 5:** Sử dụng ở bất cứ đâu bằng tên `my-app`.

---

## 4. Lệnh bảo trì quan trọng

*   **Update riêng package đó:** `cd pkgs/my-app && nix flake update`
*   **Build thử để test nhanh:** `nix build .#llama-cpp-rocm`
