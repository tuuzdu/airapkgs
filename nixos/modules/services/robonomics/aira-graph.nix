{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.aira-graph;

in {
  options = {
    services.aira-graph = {
      enable = mkEnableOption "Robonomics.network graph agent.";
    };
  };

  config = mkIf cfg.enable {
    services.liability.enable = true;

    systemd.services.aira-graph = {
      wants = [ "parity.service" "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        KEY=`ls /var/lib/parity/.local/share/io.parity.ethereum/keys/*/UTC--*|head -n1`
        ${pkgs.aira-graph}/bin/aira-graph ${config.services.liability.lighthouse} -k $KEY -w /var/lib/parity/${config.services.parity.chain}-psk
      '';

      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
