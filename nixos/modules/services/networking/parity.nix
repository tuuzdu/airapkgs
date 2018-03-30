{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.parity;

  parityHome = "/var/lib/parity";
  parityEnv = "${parityHome}/${cfg.chain}-env.sh";
  parityPsk = "${parityHome}/${cfg.chain}-psk";

in {
  options = {
    services.parity = {
      enable = mkEnableOption "Enable Parity daemon service.";

      light  = mkEnableOption "Enable Light mode.";

      unlock = mkEnableOption "Unlock account for sending transactions.";

      chain = mkOption {
        type = types.str;
        default = "foundation";
        description = "Used blockchain network name.";
      };
    };
  };

  config = mkIf cfg.enable { 
    environment.etc."parity.toml".text = ''
[parity]
# Current working blockchain name (default: foundation)
chain = "${cfg.chain}"

# Enable light mode (default: false)
light = ${if cfg.light then "true" else "false"}

# No updates will be auto-installed (nix doesn't allow this)
auto_update = "none"

[ui]
# You will need to unlock accounts manually if Wallet is disabled.
disable = ${if cfg.unlock then "true" else "false"}

[dapps]
# You won't be able to access any web Dapps.
disable = ${if cfg.unlock then "true" else "false"}

[footprint]
# Prune old state data. Maintains journal overlay - fast but extra 50MB of memory used.
pruning = "fast"

# Disable tracing.
tracing = "off"
    
'' + lib.optionalString cfg.unlock ''
[account]
unlock = ["@DEFAULT_ACCOUNT@"]
password = ["${parityPsk}"]
'';

    systemd.services.parity = {
      description = "Parity Daemon";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      preStart = (
        if !cfg.unlock then "" else ''
          [ -e ${parityEnv} ] && source ${parityEnv}

          if [ -z "$DEFAULT_ACCOUNT" ]; then
            echo "$(tr -dc A-Za-z0-9 </dev/urandom | head -c 96)" \
              > ${parityPsk} 
            echo "DEFAULT_ACCOUNT=$(${pkgs.parity}/bin/parity --chain=${cfg.chain} account new --password=${parityPsk})" \
              > ${parityEnv}
          fi
      ''); 

      script = ''
        [ -e ${parityEnv} ] && source ${parityEnv} 

        cat /etc/parity.toml | sed \
          -e "s/@DEFAULT_ACCOUNT@/$DEFAULT_ACCOUNT/" \
          | ${pkgs.parity}/bin/parity --config=/dev/stdin
      '';

      serviceConfig = {
        Restart    = "on-failure";
        KillSignal = "SIGHUP";
        StartLimitInterval = 0;
        RestartSec = 1;
        User       = "parity";
      };
    };

    users.extraUsers = singleton {
      name = "parity";
      home = "${parityHome}";
      createHome = true;
      isNormalUser = true;
      description = "Parity daemon user";
    };
  };
}
