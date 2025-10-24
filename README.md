# Câu lệnh khi build

## 1. Build bằng configuration

```nix
sudo nixos-rebuild switch
```

## 2. Build với flake

```nix
sudo nixos-rebuild switch --flake .#hostname
```

# Hướng dẫn sử dụng cấu hình WezTerm từ repo ngoài với Nix Flake

## 1. Cách cũ: Dùng trực tiếp trong module

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

## 2. Cách mới: Sử dụng flake input

- Trong `flake.nix`, thêm vào phần `inputs`:
  ```nix
  wezterm-config = {
    url = "github:qwarl/wezterm-config";
    flake = false;
  };
  ```
- Truyền `inputs` vào các module qua `home-manager.extraSpecialArgs`:
  ```nix
  home-manager.extraSpecialArgs = { inherit inputs; };
  ```
- Trong module, lấy file cấu hình như sau:
  ```nix
  let
    weztermLua = builtins.readFile "${inputs.wezterm-config}/wezterm.lua";
  in
  # ... phần còn lại như ví dụ trên
  ```

## 3. Cách sử dụng symlink cho cấu hình bên ngoài

Ngoài việc sử dụng flake input, bạn cũng có thể tạo symlink trực tiếp đến thư mục cấu hình bên ngoài:

### 3.1 Cài bằng home manager
```nix
home.file."waybar".source = ./config;
```

### 3.2 Cài với system. folder config nằm ngoài folder flake.nix
```nix
xdg.configFile.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/hyprland/Desktop/nvim"
```

**Ưu điểm:**

- Cho phép chỉnh sửa cấu hình trực tiếp mà không cần rebuild
- Thích hợp cho việc phát triển và thử nghiệm cấu hình

**Nhược điểm:**

- Phụ thuộc vào đường dẫn tuyệt đối trên hệ thống
- Không portable giữa các máy khác nhau

## 4. Lưu ý khi cấu hình

- Có thể bỏ file `./modules/shared/home-manager/packages/wezterm.nix` nếu đã import toàn bộ thư mục `packages` trong `/hosts/pc/home.nix`.

---

**Tóm lại:**

- Nên dùng cách mới với flake input để quản lý cấu hình ngoài dễ dàng hơn.
- Đảm bảo truyền đúng `inputs` vào các module cần dùng.

## 5. Xử lý lỗi thường gặp

Nếu khi chạy `nixos-rebuild` gặp lỗi như sau:

```
error: path '/nix/store/.../modules/de-wm/kde/system.nix' does not exist
```

Nguyên nhân thường là do bạn chưa thêm file mới vào git.
Hãy chạy lệnh sau để thêm file vào git, sau đó rebuild lại:

```sh
git add <đường-dẫn-file>
```

# Thử nghiệm disable bỏ kde plasma (system + HM settings)

Để tắt KDE Plasma trong cấu hình NixOS, cần comment/xóa các đoạn sau trong `flake.nix` và `configuration.nix` của host `pc`:

## Flake.nix

### 1. Comment plasma-manager input

```nix
# plasma-manager = {
#   url = "github:nix-community/plasma-manager";
#   inputs.nixpkgs.follows = "nixpkgs";
#   inputs.home-manager.follows = "home-manager";
# };
```

### 2. Comment plasma-manager trong outputs arguments

```nix
outputs =
  {
    self,
    nixpkgs,
    home-manager,
    # plasma-manager,  # <- Comment dòng này
    wezterm-config,
    ...
  }@inputs:
```

### 3. Comment imports trong user configuration

```nix
home-manager.users."kde" = {
  # imports = [
  #   ./modules/users/kde.nix
  #   inputs.plasma-manager.homeModules.plasma-manager
  # ];
};
```

## Configuration.nix

### 4. Comment import tới kde system config

Trong file `./hosts/pc/configuration.nix`, comment dòng import:

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/shared/system/aliases.nix
  # ../../modules/de-wm/kde/system.nix  # <- Comment dòng này
];
```

### 5. Disable KDE Plasma service

Trong cùng file `./hosts/pc/configuration.nix`, comment dòng enable plasma6 và sddm (sddm ko hỗ trợ hyprland dùng ly):

```nix
# services.desktopManager.plasma6.enable = true;
# services.displayManager.sddm.enable = true;
```
