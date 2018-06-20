{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
, python3Packages
, ipfs
, robonomics_comm_ethereum_common
}:

let
  pname = "robonomics_lighthouse";
  version = "0.3";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "152ydqi9ms90gjin2h318s5wk2v0f509bh2iqbr6500a0m0vdn1n";
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm ipfs pexpect base58 web3 robonomics_comm_ethereum_common ];

  meta = with stdenv.lib; {
    description = "Robonomics lighthouse support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
