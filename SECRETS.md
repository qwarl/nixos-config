# Quản lý Bí mật (Secrets Management) với sops-nix

Tài liệu này hướng dẫn cách sao lưu, sử dụng và thêm mới các bí mật (secrets) được mã hóa trong repository này.

## 1. Thành phần quan trọng nhất cần sao lưu (CRITICAL)

Để giải mã các file trong repo này, bạn **BẮT BUỘC** phải có **private age key**.

- **Đường dẫn:** `~/.config/sops/age/keys.txt`
- **Tại sao:** Nếu mất file này, bạn sẽ không bao giờ giải mã được các SSH key đã lưu trong repo.
- **Hành động:** Hãy lưu file này vào nơi an toàn (ví dụ: Password Manager như Bitwarden, USB an toàn, hoặc Vault đám mây).

**Khi sang máy mới:**
1. Copy file `keys.txt` vào đúng đường dẫn `~/.config/sops/age/keys.txt`.
2. Đảm bảo public key trong file đó trùng với public key khai báo trong file `.sops.yaml` ở gốc repo.

## 2. Cách sử dụng các key đã giải mã

Bạn **không cần làm gì thủ công**. `sops-nix` sẽ tự động giải mã khi bạn chạy `nixos-rebuild switch`.

- File đã giải mã sẽ nằm tại: `~/.ssh/id_ed25519_github_sops` (hoặc đường dẫn bạn cấu hình trong Nix).
- Bạn có thể dùng đường dẫn này trong file `~/.ssh/config`.

## 3. Cách tự thêm một bí mật mới (Ví dụ: SSH key khác)

Nếu bạn muốn tự thêm một SSH key mới vào hệ thống:

### Bước A: Lấy nội dung key cần lưu
Giả sử bạn có key `~/.ssh/id_ed25519_server`:
```bash
cat ~/.ssh/id_ed25519_server
```

### Bước B: Mở file secrets để chỉnh sửa
Dùng lệnh `sops` để mở file (nó sẽ tự giải mã tạm thời để bạn sửa):
```bash
# Nếu chưa cài sops, dùng nix shell:
nix shell nixpkgs#sops -c sops modules/shared/secrets.yaml
```

### Bước C: Thêm nội dung vào file
Trong trình soạn thảo hiện ra, thêm một field mới (chú ý thụt lề YAML):
```yaml
ssh_key: ENC[....]
server_key: |
    -----BEGIN OPENSSH PRIVATE KEY-----
    (Dán nội dung key của bạn vào đây)
    -----END OPENSSH PRIVATE KEY-----
```
Lưu và thoát. `sops` sẽ tự động mã hóa lại field mới đó.

### Bước D: Cấu hình trong Nix
Mở file `modules/shared/home-manager/packages/sops.nix` và thêm khai báo để Nix biết chỗ đặt file sau khi giải mã:

```nix
sops.secrets.server_key = {
  path = "${config.home.homeDirectory}/.ssh/id_ed25519_server_sops";
};
```

Sau đó chạy `nixos-rebuild switch` để áp dụng.
