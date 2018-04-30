{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_control
, robonomics_comm_liability
, robonomics_comm_lighthouse
, robonomics_comm_ethereum_common
}:

let
  pname = "robonomics_comm";
  version = "0.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "0nvc3kjpmfg2rmsaxvcv78bdh3v35bav37izi5m43xhx672zbh0c";
  };

  propagatedBuildInputs =
  [ robonomics_comm_lighthouse
    robonomics_comm_control
    robonomics_comm_liability
    robonomics_comm_ethereum_common ];

  meta = with stdenv.lib; {
    description = "Robonomics communication stack meta-package";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
