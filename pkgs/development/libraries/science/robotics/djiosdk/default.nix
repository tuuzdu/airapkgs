{ stdenv
, fetchFromGitHub
, cmake
}:

stdenv.mkDerivation rec {
  name = "djiosdk-${version}";
  version = "3.6.1";

  src = fetchFromGitHub {
    owner = "dji-sdk";
    repo = "Onboard-SDK";
    rev = "${version}";
    sha256 = "1nq9b97ywh3fm4hza66fqmr4fd6y6kjz2ch02k7xnywyrarssv3a";
  };

  patches = [ ./sys_select.patch ];

  buildInputs = [ cmake ];

  meta = with stdenv.lib; {
    description = "DJI Onboard SDK";
    homepage = https://github.com/dji-sdk/Onboard-SDK;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru ];
  };

  
}
