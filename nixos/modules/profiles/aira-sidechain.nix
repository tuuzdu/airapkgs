{ config, ... }:

{
  # Enable light robot liability service
  services.liability = {
    enable = true;
    web3_http_provider = "https://sidechain.aira.life";
    web3_ws_provider = "wss://sidechain.aira.life/ws";
    lighthouse = "airalab.lighthouse.4.robonomics.sid";
    ens = "0x2286921A25b3f2Dfe4E97B73E88EeB5f3E48FFd7";
  };
}
