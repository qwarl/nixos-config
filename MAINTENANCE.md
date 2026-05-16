# Ghi chú bảo trì hệ thống (Maintenance Notes)

## 1. Vấn đề WireGuard VPN & Port Forwarding

### Tình trạng hiện tại (Ngày 05/05/2026)
- **Vấn đề:** Modem FPT hiện tại không cho phép chọn giao thức **UDP** trong mục Virtual Server, dẫn đến việc WireGuard không thể "bắt tay" (handshake).
- **Giải pháp tạm thời:** Đã bật **DMZ** cho IP Server (`192.168.1.49`).
- **Rủi ro:** DMZ mở toàn bộ cổng của Server ra Internet. **CỰC KỲ KHÔNG AN TOÀN**. Cần sớm cấu hình lại Port Forwarding đúng cổng và tắt DMZ.

### Yêu cầu cần gọi Tổng đài FPT (1800 6000)
Bạn cần gọi điện và yêu cầu kỹ thuật viên hỗ trợ các nội dung sau:
1.  **Yêu cầu chính:** Mở port **51820** với giao thức **UDP** trỏ về địa chỉ IP nội bộ `192.168.1.49`.
2.  **Lý do:** Modem dòng cũ/Firmware cũ không có tùy chọn giao thức UDP trong phần Virtual Server.
3.  **Phương án thay đổi:** Nếu Modem không hỗ trợ, yêu cầu cập nhật Firmware hoặc đổi dòng Modem mới hơn (ví dụ AC1000F) có hỗ trợ đầy đủ TCP/UDP.

---

## 2. Lưu ý Bảo mật khi đang bật DMZ

Trong khi chưa tắt được DMZ, tuyệt đối tuân thủ:
- **SSH:** Đảm bảo `PasswordAuthentication` luôn là `no` (Chỉ dùng SSH Key).
- **Firewall NixOS:** Chỉ mở những cổng thực sự cần thiết trong `hosts/server/configuration.nix`.
- **Dịch vụ Web:** Các dịch vụ như Vaultwarden, AdGuard Home phải có mật khẩu cực mạnh và nên chạy qua Reverse Proxy có HTTPS.

## 3. Kiểm tra sau khi cấu hình
Sau khi kỹ thuật viên FPT báo đã mở port xong:
1.  Vào Modem tắt **DMZ**.
2.  Bật VPN trên điện thoại (4G/5G).
3.  Kiểm tra bằng lệnh: `sudo wg show`. Nếu có dòng `latest handshake` và vẫn vào được mạng là thành công.
