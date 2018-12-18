{ config, pkgs, lib, ... }:

{

  imports = [
    ../profiles/aira.nix
  ];

  # https://github.com/NixOS/nixpkgs/issues/26776
  systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  services = {
    # Enable OpenSSH by default
    openssh.enable = true;

    # Enable mouse integration
    gpm.enable = true;

    # Enable light robot liability service
    liability = {
      enable = true;
      web3_http_provider = "https://mainnet.infura.io/v3/cd7368514cbd4135b06e2c5581a4fff7";
      web3_ws_provider = "wss://mainnet.infura.io/ws";
      lighthouse = "airalab.lighthouse.4.robonomics.eth";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    loginShellInit = ''
      echo -e "Starting..."
      sleep 5
      ${pkgs.figlet}/bin/figlet AIRA
      export ADDRESS=`cat /var/lib/liability/keyfile|${pkgs.jq}/bin/jq ".address"`
      echo -e "\nMy Ethereum address is $ADDRESS"
      export ID=`${pkgs.ipfs}/bin/ipfs --api /ip4/127.0.0.1/tcp/5001 id|${pkgs.jq}/bin/jq ".ID"`
      echo -e "\nLook me at https://status.robonomics.network by $ID\n\n"
    '';
    shellInit = ''
      source ${pkgs.hello_aira}/setup.zsh
    '';
  };

  # Allow the user to log in as root without a password.
  users.extraUsers.root.shell = pkgs.zsh;

  # Useful preinstall utils
  environment.systemPackages = with pkgs; [
    vim git htop screen mosh cmake gcc
  ];

}
