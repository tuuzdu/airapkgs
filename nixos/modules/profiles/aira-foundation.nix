{ config, ... }:

{
  # Enable light robot liability service
  services.liability = {
    enable = true;
    web3_http_provider = "https://mainnet.infura.io/v3/cd7368514cbd4135b06e2c5581a4fff7";
    web3_ws_provider = "wss://mainnet.infura.io/ws";
    lighthouse = "airalab.lighthouse.4.robonomics.eth";
  };
}
