let
  version     = "2.2.4";
  sha256      = "12qcfmc56vnay25nlflgwhm3iwlr7hd286wzzanlsalizaj5s5ja";
  cargoSha256 = "0pv4j111f1wlnqgqqx2q9z0ns529cc1c35sr9mz8jxywya7v6im5";
in
  import ./parity.nix { inherit version sha256 cargoSha256; }
