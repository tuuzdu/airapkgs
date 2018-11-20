{ config, pkgs, ... }:

{

  imports = [
    ../profiles/aira.nix
  ];

  services = {
    # Enable OpenSSH by default
    openssh.enable = true;

    # Enable mouse integration
    gpm.enable = true;

    # Enable light robot liability service
    liability.enable = true;
    liability.web3_http_provider = "https://mainnet.infura.io/v3/cd7368514cbd4135b06e2c5581a4fff7";
    liability.web3_ws_provider = "wss://mainnet.infura.io/ws";
    liability.lighthouse = "airalab.lighthouse.3.robonomics.eth";

    # Enable graph monitoring
    aira-graph.enable = true;
    aira-graph.graph = "graph.3.robonomics.eth";
    aira-graph.lighthouse = "airalab.lighthouse.3.robonomics.eth";

    # Root autologin by default
    mingetty.autologinUser = "root";
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
      echo -e "\nLook me at https://status.robonomics.network by $ID"
      source ${pkgs.hello_aira}/setup.zsh
      echo -e "\n\n"
    '';
  };

  # Allow the user to log in as root without a password.
  users.extraUsers.root = {
    initialHashedPassword = "";
    shell = pkgs.zsh;
  };

  # Useful preinstall utils
  environment.systemPackages = with pkgs; [
    vim git htop screen cmake gcc robonomics-tools
  ];

}
