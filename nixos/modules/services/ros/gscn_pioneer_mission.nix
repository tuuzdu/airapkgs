{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.gscn_pioneer_mission;

in {
  options = {
    services.gscn_pioneer_mission = {
      enable = mkEnableOption "Pioneer mavros node.";

      package = mkOption {
        type = types.package;
        default = pkgs.gscn_pioneer_mission;
        defaultText = "pkgs.gscn_pioneer_mission";
        description = "Pioneer mavros node";
      };

      ros_ip = mkOption {
        type = types.str;
        default = "10.0.0.1";
        description = "ROS master IP";
      };

    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.services.gscn_pioneer_mission = {
      requires = [ "roscore.service" ];
      after = [ "roscore.service" ];
      wantedBy = [ "multi-user.target" ];

      # environment.ROS_MASTER_URI = cfg.ros_master_uri;
      environment.ROS_IP = cfg.ros_ip;

      script = ''
        source ${cfg.package}/setup.bash \
          && roslaunch gscn_pioneer_mission gscn_mavros.launch
      '';

      serviceConfig = {
        Restart = "on-failure";
        StartLimitInterval = 0;
        RestartSec = 60;
      };
    };

  };
}
