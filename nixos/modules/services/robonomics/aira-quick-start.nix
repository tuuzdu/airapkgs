{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.aira-quick-start;

in {
  options = {
    services.aira-quick-start = {
      enable = mkEnableOption "Quick start scripts for AIRA instance.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ python3 python3Packages.web3 ];
    # Enable dependencies
    services = {
      # Ethereum network client
      parity.enable = true;
      parity.unlock = true;
    };

    systemd.services.aira-quick-start = {
      wants = [ "parity.service" ];
      wantedBy = [ "multi-user.target" ];
      conflicts = [ "getty@tty1.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.aira-quick-start}/bin/aira-quick-start";
        Restart = "on-failure";
        RestartSec = 5;
        StandardInput = "tty";
        StandardOutput ="tty";
        TTYPath = "/dev/tty1";
        TTYReset = true;
        TTYVTDisallocate = true;
      };
    };
  };
}
