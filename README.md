# Lệnh khi build

## 1. Build bằng configuration

```nix
sudo nixos-rebuild switch
```

## 2. Build với flake

```nix
sudo nixos-rebuild switch --flake .#hostname
```

# Hướng dẫn: sử dụng cấu hình WezTerm từ repo ngoài (với Nix Flake)

Phần này mô tả ba cách phổ biến để dùng cấu hình WezTerm ngoài (fetch trực tiếp, dùng flake input, hoặc tạo symlink).

## 1) Cách cũ — fetch trực tiếp trong module

Ví dụ: dùng `builtins.fetchGit` trong module để lấy file `wezterm.lua`:

```nix
{ lib, config, ... }:
let
  weztermRepo = builtins.fetchGit {
    url = "https://github.com/qwarl/wezterm-config.git";
    rev = "be02802a22979e752b4f7bf78bab74a47dca9e4f";
  };
  weztermLua = builtins.readFile "${weztermRepo}/wezterm.lua";
in
{
  options = {
    weztermMod = lib.mkEnableOption "enables weztermMod";
  };

  config = lib.mkIf config.weztermMod {
    programs.wezterm = {
      enable = true;
      extraConfig = weztermLua;
    };
  };
}
```

## 2) Cách mới — dùng flake input (đề xuất)

- Trong `flake.nix`, thêm input:

```nix
wezterm-config = {
  url = "github:qwarl/wezterm-config";
  flake = false;
};
```

- Truyền `inputs` vào các module (ví dụ qua `home-manager.extraSpecialArgs`):

```nix
home-manager.extraSpecialArgs = { inherit inputs; };
```

- Trong module, đọc file:

```nix
let
  weztermLua = builtins.readFile "${inputs.wezterm-config}/wezterm.lua";
in
# ... sử dụng `weztermLua` như ví dụ ở trên
```

Ưu điểm của cách này: gọn, dễ quản lý, và portable hơn so với symlink tuyệt đối.

## 3) Dùng symlink cho cấu hình bên ngoài

Bạn có thể dùng symlink nếu muốn chỉnh sửa cấu hình mà không cần rebuild.

- Ví dụ cài bằng Home Manager (relative path từ file Nix gọi `home.file`):

```nix
home.file."waybar".source = ./config;
```

- Hoặc tạo symlink out-of-store (đường dẫn tuyệt đối trong hệ thống):

```nix
xdg.configFile.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/hyprland/Desktop/nvim";
```

Ghi chú về đường dẫn:

- `home.file."...".source = ./path` — đường dẫn tương đối so với file Nix đang gọi.
- `mkOutOfStoreSymlink "/abs/path"` — dùng đường dẫn tuyệt đối trong hệ thống.

---

## Tóm tắt

- Khuyến nghị: dùng flake input khi có thể — dễ quản lý và portable.
- Đảm bảo truyền đúng `inputs` vào module cần dùng.

## Xử lý lỗi thường gặp

Ví dụ lỗi khi chạy `nixos-rebuild`:

```text
error: path '/nix/store/.../modules/de-wm/kde/system.nix' does not exist
```

Nguyên nhân phổ biến: quên thêm file vào git (file mới chưa được tracked). Thao tác khắc phục nhanh:

```sh
git add <đường-dẫn-file>
nixos-rebuild switch --flake .#hostname
```

---

# Thử nghiệm: tắt (disable) KDE Plasma (system + Home Manager)

Nếu muốn tắt KDE Plasma trên host `pc`, bạn có thể comment/xóa các đoạn liên quan trong `flake.nix` và `./hosts/pc/configuration.nix`.

### Flake.nix — ví dụ

1) Comment phần `plasma-manager` trong `inputs` (nếu có):

```nix
# plasma-manager = {
#   url = "github:nix-community/plasma-manager";
#   inputs.nixpkgs.follows = "nixpkgs";
#   inputs.home-manager.follows = "home-manager";
# };
```

2) Nếu `plasma-manager` được liệt kê trong `outputs`, comment nó đi:

```nix
outputs = { self, nixpkgs, home-manager, # plasma-manager,
  wezterm-config, ... }@inputs:
```

3) Trong phần `home-manager.users."kde"`, bỏ import tới `plasma-manager` nếu có:

```nix
home-manager.users."kde" = {
  # imports = [ ./modules/users/kde.nix inputs.plasma-manager.homeModules.plasma-manager ];
};
```

### hosts/pc/configuration.nix — ví dụ

4) Comment import tới `kde` system config:

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/shared/system/aliases.nix
  # ../../modules/de-wm/kde/system.nix
];
```

5) Comment hoặc tắt dịch vụ Plasma / display manager nếu cần:

```nix
# services.desktopManager.plasma6.enable = true;
# services.displayManager.sddm.enable = true;
```
