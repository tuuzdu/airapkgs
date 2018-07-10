{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.lighthouse;

  defaultContract = "airalab.lighthouse.0.robonomics.eth";

in {
  options = {
    services.lighthouse = {
      enable = mkEnableOption "Enable Robonomics Lighthouse service.";

      contract = mkOption {
        type = types.str;
        default = defaultContract; 
        description = "Lighthouse contract address.";
      };

      gasprice = mkOption {
        type = types.int;
        default = 0;
        description = "Lighthouse transaction gasprice in gwei, default: 0 - auto.";
      };

      user = mkOption {
        type = types.str;
        default = "lighthouse";
        description = "User account under which service runs.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ robonomics_comm ];

    # Enable dependencies
    services = {
      # Ethereum network client
      parity = {
        enable = true;
        unlock = true;
      };

      # IPFS network client
      ipfs = {
        enable = true;
        pubsubExperiment = true;
        extraConfig = {
          Bootstrap = [
            "/dns4/lighthouse.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
            "/dns6/h.lighthouse.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
          ];
        };
      };
    };

    systemd.services.lighthouse = {
      wants = [ "parity.service" "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        source ${pkgs.robonomics_comm}/setup.bash \
          && roslaunch robonomics_lighthouse lighthouse.launch \
            lighthouse_contract:="${cfg.contract}" gas_price_gwei:=${builtins.toString cfg.gasprice}
      '';

      serviceConfig = {
        Restart = "on-failure";
        StartLimitInterval = 0;
        RestartSec = 60;
        User = cfg.user;
      };
    };

    users.extraUsers = singleton {
      name = cfg.user;
      home = "/var/lib/lighthouse";
      createHome = true;
      isNormalUser = true;
    };
  };
}
