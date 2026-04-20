{ pkgs }:

(pkgs.llama-cpp.override {
  rocmSupport = true;
  cudaSupport = false;
  blasSupport = true;
}).overrideAttrs
  (old: rec {
    version = "8855";

    src = pkgs.fetchFromGitHub {
      owner = "ggml-org";
      repo = "llama.cpp";
      rev = "b${version}";
      hash = "sha256-idPlkb794dyVrFw/0fl/GoDpRGBYgn7yTS9uOitKuM4=";
    };

    npmDepsHash = "sha256-RAFtsbBGBjteCt5yXhrmHL39rIDJMCFBETgzId2eRRk=";

    cmakeFlags = (old.cmakeFlags or [ ]) ++ [
      "-DGGML_HIP=ON"
      "-DAMDGPU_TARGETS=gfx1200"
      "-DGGML_NATIVE=ON"
      "-DCMAKE_HIP_ARCHITECTURES=gfx1200"
    ];

    preConfigure = ''
      export HIPCXX="${pkgs.rocmPackages.clang}/bin/clang++"
      export HIP_PATH="${pkgs.rocmPackages.clr}"
      export ROCM_PATH="${pkgs.rocmPackages.clr}"
      export HIP_PLATFORM=amd

      # Fix CMake tìm hip-lang-config.cmake trên stable
      export CMAKE_PREFIX_PATH="${pkgs.rocmPackages.clr}/lib/cmake:${pkgs.rocmPackages.clr}/lib64/cmake:''${CMAKE_PREFIX_PATH:-}"
      export CMAKE_LIBRARY_PATH="${pkgs.rocmPackages.clr}/lib:''${CMAKE_LIBRARY_PATH:-}"
      export CMAKE_INCLUDE_PATH="${pkgs.rocmPackages.clr}/include:''${CMAKE_INCLUDE_PATH:-}"

      ${old.preConfigure or ""}
    '';

    enableParallelBuilding = true;
  })
