{ config, pkgs, ... }:

{

  imports = [
    ../profiles/aira.nix
  ];

  services = {
    aira-quick-start.enable = true;
    parity.chain = "kovan";
  };

}
