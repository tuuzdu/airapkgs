{ config, ... }:

let
  web3_http_provider = "https://sidechain.aira.life/rpc";
  web3_ws_provider = "wss://sidechain.aira.life/ws";
  lighthouse = "airalab.lighthouse.4.robonomics.sid";
  factory = "factory.4.robonomics.sid";
  graph_topic = "graph.4.robonomics.sid";
  token = "xrt.4.robonomics.sid";
  ens = "0x4e978ed8A05b516D8130Ff7dF54Fbc8b7ceB6442";

in {
  # Enable light robot liability service
  services.liability = {
    enable = true;
    inherit ens web3_http_provider web3_ws_provider lighthouse factory graph_topic;
  };

  # Set params for XRT
  services.erc20 = {
    enable = true;
    inherit ens web3_http_provider web3_ws_provider token factory;
  };
}
