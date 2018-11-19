{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xrtd;

in {
  options = {
    services.xrtd = {
      enable = mkEnableOption "Robonomics.network provider daemon.";

      hexKeyfile = mkOption {
        type = types.str;
        description = "Hex encoded private key file";
      };

      web3_provider = mkOption {
        type = types.str;
        default = "";
        description = "Web3 provider URI";
      };

      ipfs_provider = mkOption { 
        type = types.str;
        default = "";
        description = "IPFS provider multiaddress";
      };

      lighthouse = mkOption {
        type = types.str;
        default = "";
        description = "Lighthouse ENS";
      };

      ens = mkOption {
        type = types.str;
        default = "";
        description = "ENS registry address";
      };

    };
  };

  config = mkIf cfg.enable {
    systemd.services.xrtd = {
      wants = [ "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];

      path = with pkgs; [ bash ipfs ];

      script = ''
        ${pkgs.robonomics-tools}/bin/xrtd --private "$(cat ${cfg.hexKeyfile})" ${optionalString (cfg.web3_provider != "") "--web3 \"${cfg.web3_provider}\""} ${optionalString (cfg.ipfs_provider != "") "--ipfs \"${cfg.ipfs_provider}\""} ${optionalString (cfg.lighthouse != "") "--lighthouse \"${cfg.lighthouse}\""} ${optionalString (cfg.ens != "") "--ens \"${cfg.ens}\""} 
      '';

      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
