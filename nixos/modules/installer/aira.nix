{ config, pkgs, ... }:

{

  imports = [
    ../profiles/aira.nix
  ];

  services.liability.enable = true;
  services.liability.web3_http_provider = "https://mainnet.infura.io/v3/cd7368514cbd4135b06e2c5581a4fff7";
  services.liability.web3_ws_provider = "wss://mainnet.infura.io/ws";
  services.aira-graph.enable = true;

  services.mingetty.autologinUser = "root";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    loginShellInit = ''
      source /var/lib/parity/${config.services.parity.chain}-env.sh
      ${pkgs.figlet}/bin/figlet AIRA
      echo -e "\tEthereum account: $DEFAULT_ACCOUNT"
      export ID=`${pkgs.ipfs}/bin/ipfs --api /ip4/127.0.0.1/tcp/5001 id|${pkgs.jq}/bin/jq ".ID"`
      echo -e "\tIPFS ID: $ID"
      echo -e "\nLook at https://dev.aira.life/graph by $ID"
      source ${pkgs.hello_aira}/setup.zsh
      echo -e "\n\n"
    '';
  };

  # Allow the user to log in as root without a password.
  users.extraUsers.root = {
    initialHashedPassword = "";
    shell = pkgs.zsh;
  };

}
