let
  version     = "2.1.9";
  sha256      = "1xxpv2cxfcjwxfxkn2732y1wxh9rpiwmlb2ij09cg5nph669hy0v";
  cargoSha256 = "12fv5g6ji7b2r62gr7am5vpsh3jp8jh74q738hkjxm268gcrk9yz";
in
  import ./parity.nix { inherit version sha256 cargoSha256; }
