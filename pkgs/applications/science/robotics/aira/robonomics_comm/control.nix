{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_lighthouse
, python3Packages
}:

let
  pname = "robonomics_control";
  version = "0.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "1wb5115ld6im50b3kk4d8wawqr56h9d4vaqlvmxkzn166w9a98ha";
  };

  propagatedBuildInputs = with python3Packages; [ robonomics_comm_lighthouse web3 numpy ];

  meta = with stdenv.lib; {
    description = "Set of robonomics control algorithms";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
