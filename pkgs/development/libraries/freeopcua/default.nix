{ stdenv
, fetchFromGitHub
, cmake
, pkgconfig
, boost
, libxml2
}:

stdenv.mkDerivation {
  name = "freeopcua_2016-04-18";

  src = fetchFromGitHub {
    owner = "FreeOpcUa";
    repo = "freeopcua";
    rev = "43b86aea4d33c7f3fb982b95e4248d3992c10961";
    sha256 = "0njr7p7j55w48axzfxcbr14zc0g8h35dmq27rc3kxlc438xdj0b8";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ boost libxml2 ];

  cmakeFlags = [ "-DBUILD_SERVER=OFF" ];

  meta = with stdenv.lib; {
    homepage = https://github.com/FreeOpcUa/freeopcua;
    license = licenses.lgpl3;
    shortDescription = "Open Source C++ OPC-UA Server and Client Library";
    platforms = platforms.linux;
    maintainers = with maintainers; [ akru ];
  };
}
