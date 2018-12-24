{ config, ... }:

{
  # Enable light robot liability service
  services.liability = {
    enable = true;
    web3_http_provider = "https://sidechain.aira.life/rpc";
    web3_ws_provider = "wss://sidechain.aira.life/ws";
    lighthouse = "airalab.lighthouse.4.robonomics.sid";
    ens = "0x4e978ed8A05b516D8130Ff7dF54Fbc8b7ceB6442";
  };
}
