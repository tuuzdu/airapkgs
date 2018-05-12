let
  version     = "1.10.3";
  sha256      = "1rci8rdsc05fsfr6man0k9qrmymss77x9igyr928x8d7b6jvqa3s";
  cargoSha256 = "1sxqkg0wajz1k456kxw3401vcf6fzm3r2zp6ny8vwl2jwmz33s5k";
  patches     = [ ./patches/vendored-sources-1.10.patch ];
in
  import ./parity.nix { inherit version sha256 cargoSha256 patches; }
