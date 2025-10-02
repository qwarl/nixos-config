{ lib, config, ... }:{

  options = {
    optimizedDocumentation = lib.mkEnableOption "enables optimized documentation settings for faster rebuilding";
  };

  config = lib.mkIf config.optimizedDocumentation {
    # Faster rebuilding
    documentation = {
      enable = true;
      doc.enable = false;
      man.enable = true;
      dev.enable = false;
      info.enable = false;
      nixos.enable = false;
    };
  };
}
