{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.liability;

  mainnetEns = "0x314159265dD8dbb310642f98f50C066173C1259b";
  defaultContract = "airalab.lighthouse.1.robonomics.eth";

in {
  options = {
    services.liability = {
      enable = mkEnableOption "Enable Robonomics liability executor service.";

      ens = mkOption {
        type = types.str;
        default = mainnetEns;
        description = "Ethereum name regustry address.";
      };

      lighthouse = mkOption {
        type = types.str;
        default = defaultContract; 
        description = "Lighthouse contract address.";
      };

      user = mkOption {
        type = types.str;
        default = "liability";
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
          && roslaunch robonomics_liability liability.launch \
              ens_contract:="${cfg.ens}" lighthouse_contract:="${cfg.lighthouse}"
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
