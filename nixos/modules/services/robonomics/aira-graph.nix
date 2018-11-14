{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.aira-graph;

in {
  options = {
    services.aira-graph = {
      enable = mkEnableOption "Robonomics.network graph agent.";

      graph = mkOption {
        type = types.str;
        description = "AIRA graph topic";
      };

      lighthouse = mkOption {
        type = types.str;
        description = "Lighthouse topic";
      };

      keyfile = mkOption {
        type = types.str;
        default = config.services.liability.keyfile;
        description = "Default keyfile for signing messages.";
      };

      keyfile_password_file = mkOption {
        type = types.str;
        default = config.services.liability.keyfile_password_file;
        description = "Password file for keyfile.";
      };

    };
  };

  config = mkIf cfg.enable {
    systemd.services.aira-graph = {
      wants = [ "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = ''
          ${pkgs.aira-graph}/bin/aira-graph ${cfg.graph} ${cfg.lighthouse} \
            -k ${cfg.keyfile} -w ${cfg.keyfile_password_file} 
        '';
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
