{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_lighthouse
, python3Packages
, ros_comm
}:

let
  pname = "ethereum_common";
  version = "0.1.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "1lfv2blf8s8262k6n85maj1975nxn37bfci8h8xy6q7s8w1kmgsz";
  };

  propagatedBuildInputs = with python3Packages; [ ros_comm web3 ];

  meta = with stdenv.lib; {
    description = "Commonly used Ethereum communication nodes";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
