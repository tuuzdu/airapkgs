{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_lighthouse
, python3Packages
}:

let
  pname = "robonomics_control";
  version = "0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "1drs3d53ry0zmvp3xqqx5fhapc2sxi6yb1xzlaxm4mm64kh4fav3";
  };

  propagatedBuildInputs = with python3Packages; [ robonomics_comm_lighthouse web3 numpy ];

  meta = with stdenv.lib; {
    description = "Set of robonomics control algorithms";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
