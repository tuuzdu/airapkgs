{ config, lib, pkgs, ... }:

with lib;

{

  services = {
    aira-quick-start.enable = true;
    parity.chain = "kovan";
  };

  # Allow the user to log in as root without a password.
  users.extraUsers.root.initialHashedPassword = "";

  nix.binaryCaches = [ https://cache.nixos.org https://hydra.aira.life ];
  nix.binaryCachePublicKeys = [ "hydra.aira.life-1:StgkxSYBh18tccd4KUVmxHQZEUF7ad8m10Iw4jNt5ak=" ];

}
