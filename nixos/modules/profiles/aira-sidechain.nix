{ config, ... }:

{
  # Enable light robot liability service
  services.liability = {
    enable = true;
    web3_http_provider = "https://sidechain.aira.life";
    web3_ws_provider = "wss://sidechain.aira.life/ws";
    lighthouse = "airalab.lighthouse.4.robonomics.sid";
  };
}
