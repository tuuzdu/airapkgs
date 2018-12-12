{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.liability;

  mainnetEns = "0x314159265dD8dbb310642f98f50C066173C1259b";
  liabilityHome = "/var/lib/liability";
  keyfile = "${liabilityHome}/keyfile";
  keyfile_password_file = "${liabilityHome}/keyfile-psk";

  python-eth_keyfile = pkgs.python3.withPackages (ps : with ps; [ eth-keyfile ]);

in {
  options = {
    services.liability = {
      enable = mkEnableOption "Enable Robonomics liability executor service.";

      package = mkOption {
        type = types.package;
        default = pkgs.robonomics_comm;
        defaultText = "pkgs.robonomics_comm";
        description = "Robonomics communication stack to use";
      };

      ens = mkOption {
        type = types.str;
        default = mainnetEns;
        description = "Ethereum name regustry address.";
      };

      lighthouse = mkOption {
        type = types.str;
        description = "Lighthouse contract address.";
      };

      user = mkOption {
        type = types.str;
        default = "liability";
        description = "User account under which service runs.";
      };

      keyfile = mkOption {
        type = types.str;
        default = keyfile;
        description = "Default keyfile for signing messages.";
      };

      keyfile_password_file = mkOption {
        type = types.str;
        default = keyfile_password_file;
        description = "Password file for keyfile.";
      };

      web3_http_provider = mkOption {
        type = types.str;
        default = "http://127.0.0.1:8545";
        description = "Web3 http provider address";
      };

      web3_ws_provider = mkOption {
        type = types.str;
        default = "ws://127.0.0.1:8546";
        description = "Web3 websocket provider address";
      };

      enable_aira_graph = mkEnableOption "Enable aira_graph node";

      ros_master_uri = mkOption {
        type = types.str or null;
        default = null;
        description = "ROS master node location";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    # Enable dependencies
    services = {
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

    systemd.services.liability = {
      wants = [ "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];

      environment =
        if cfg.ros_master_uri != null
        then { ROS_MASTER_URI = cfg.ros_master_uri; }
        else {};

      preStart = ''
        if [ ! -e ${cfg.keyfile} ]; then
          PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c32)
          echo $PASSWORD > ${cfg.keyfile_password_file}
          ${python-eth_keyfile}/bin/python -c "import os,eth_keyfile,json; print(json.dumps(eth_keyfile.create_keyfile_json(os.urandom(32), '$PASSWORD'.encode())))" > ${cfg.keyfile}
        fi
      '';

      script = ''
        source ${cfg.package}/setup.bash \
          && roslaunch robonomics_liability liability.launch \
              ens_contract:="${cfg.ens}" \
              lighthouse_contract:="${cfg.lighthouse}" \
              keyfile:="${cfg.keyfile}" \
              keyfile_password_file:="${cfg.keyfile_password_file}" \
              web3_http_provider:="${cfg.web3_http_provider}" \
              web3_ws_provider:="${cfg.web3_ws_provider}" \
              enable_aira_graph:="${if cfg.enable_aira_graph then "true" else "false"}"
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
      home = "${liabilityHome}";
      createHome = true;
      isNormalUser = true;
    };
  };
}
