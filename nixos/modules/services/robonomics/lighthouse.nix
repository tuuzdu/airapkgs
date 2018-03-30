{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.lighthouse;

  defaultContract = "0x9c8DD1E767f54520B4fb1A6E306F172EA8492f9c";

in {
  options = {
    services.lighthouse = {
      enable = mkEnableOption "Enable Robonomics Lighthouse service.";

      contract = mkOption {
        type = types.str;
        default = defaultContract; 
        description = "Lighthouse contract address.";
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
      parity.enable = true;
      parity.unlock = true;

      # IPFS network client
      ipfs.enable = true;
      ipfs.pubsubExperiment = true;
      ipfs.extraConfig = {
          Announce = [
            "/dns4/pool.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
          ];
      };
    };

    systemd.services.lighthouse = {
      wants = [ "parity.service" "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];
      script = ''
        source ${pkgs.robonomics_comm}/setup.bash \
          && roslaunch robonomics_lighthouse lighthouse.launch \
            lighthouse_contract:="${cfg.contract}"
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
