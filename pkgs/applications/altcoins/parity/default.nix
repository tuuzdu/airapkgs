let
  version     = "1.10.4";
  sha256      = "1vyqid2m1y06zm451fdn208h20r04cymdrra0l014swlis2vbjdc";
  cargoSha256 = "1sxqkg0wajz1k456kxw3401vcf6fzm3r2zp6ny8vwl2jwmz33s5k";
  patches     = [ ./patches/vendored-sources-1.10.patch ];
in
  import ./parity.nix { inherit version sha256 cargoSha256 patches; }
