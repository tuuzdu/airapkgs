let
  version     = "1.11.0";
  sha256      = "0xxiwzh0i7g0argald1afm1k8cnfvq5bz0zqa3mgkhjx49771q8q";
  cargoSha256 = "1cbq03ay8a43bir4i65kp43d69f3aqmvl887vwdpk58nwj315kk3";
  patches     = [ ./patches/vendored-sources-1.11.patch ];
in
  import ./parity.nix { inherit version sha256 cargoSha256 patches; }
