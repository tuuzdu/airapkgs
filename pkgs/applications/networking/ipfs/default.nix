{ stdenv, buildGo111Package, go_1_11, gx, gx-go, fetchFromGitHub, fetchgx }:

let
  fetchgx' = fetchgx.override {
    go = go_1_11;
    gx = gx.override { buildGoPackage = buildGo111Package; };
    gx-go = gx-go.override { buildGoPackage = buildGo111Package; }; 
  };
  buildGoPackage = buildGo111Package; 

in buildGoPackage rec {
  name = "ipfs-${version}";
  version = "0.4.18";
  rev = "v${version}";

  goPackagePath = "github.com/ipfs/go-ipfs";

  extraSrcPaths = [
    (fetchgx' {
      inherit name src;
      sha256 = "05d5m6c2i2kl4rvb0hddyqbidn76ljr2zryi8v2r9i8dbi0164gm";
    })
  ];

  src = fetchFromGitHub {
    owner = "ipfs";
    repo = "go-ipfs";
    inherit rev;
    sha256 = "0h4j18qpycfmmlhb9khvhbk8c1zqajflvw8gk3l8j7wxrxh5j2s6";
  };

  meta = with stdenv.lib; {
    description = "A global, versioned, peer-to-peer filesystem";
    homepage = https://ipfs.io/;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ fpletz ];
  };
}
