{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_msgs
, robonomics_comm_control
, robonomics_comm_liability
, robonomics_comm_lighthouse
, robonomics_comm_ethereum_common
}:

let
  pname = "robonomics_comm";
  version = "0.3.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "0r1swvva2ikk7bqmrj5pf6vpalnmkhjkbvrslz059ihklq0ahl4n";
  };

  propagatedBuildInputs =
  [ robonomics_comm_msgs
    robonomics_comm_control
    robonomics_comm_liability
    robonomics_comm_lighthouse
    robonomics_comm_ethereum_common ];

  meta = with stdenv.lib; {
    description = "Robonomics communication stack meta-package";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
