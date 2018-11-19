{ config, pkgs, ... }:

{

  imports = [
    ../profiles/aira.nix
  ];

  # Enable OpenSSH by default
  services.openssh.enable = true;

  # Enable light robot liability service
  services.liability.enable = true;
  services.liability.web3_http_provider = "https://mainnet.infura.io/v3/cd7368514cbd4135b06e2c5581a4fff7";
  services.liability.web3_ws_provider = "wss://mainnet.infura.io/ws";
  services.liability.lighthouse = "airalab.lighthouse.3.robonomics.eth";

  # Enable graph monitoring
  services.aira-graph.enable = true;
  services.aira-graph.graph = "graph.3.robonomics.eth";
  services.aira-graph.lighthouse = "airalab.lighthouse.3.robonomics.eth";

  # Root autologin by default
  services.mingetty.autologinUser = "root";

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
      echo -e "\nLook me at https://dev.aira.life/graph by $ID"
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
