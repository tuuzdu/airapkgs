{ config, ... }:

{

  nix = {
    binaryCaches = [
      https://cache.nixos.org
      https://hydra.aira.life
    ];

    binaryCachePublicKeys = [
      "hydra.aira.life-1:StgkxSYBh18tccd4KUVmxHQZEUF7ad8m10Iw4jNt5ak="
    ];
  };

}
