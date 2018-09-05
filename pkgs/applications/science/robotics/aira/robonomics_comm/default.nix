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
  version = "0.2";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "11f9yfd5b10q8yafwkvmrjsr5rvx1w2g8hh7p7vliqci4xlr8hzn";
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
