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
    services.parity = {
      enable = true;
      unlock = true;
    };

    systemd.services.aira-quick-start = {
      wants = [ "parity.service" ];
      wantedBy = [ "multi-user.target" ];
      conflicts = [ "getty@tty1.service" ];

      environment = {
        inherit (config.environment.sessionVariables) NIX_PATH;
        HOME = "/root";
      };

      path = with pkgs; [ python3 python3Packages.web3 config.nix.package.out ];

      script = ''
        ${pkgs.aira-quick-start}/bin/aira-quick-start \
          && ${config.system.build.nixos-rebuild}/bin/nixos-rebuild switch
      '';

      serviceConfig = {
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
