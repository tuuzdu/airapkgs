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
  version = "0.3.1";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "1pp699vmbpwhw4xbm1rrnh20p0ra6a05ycszrnwk082mqs0p2nqr";
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm ipfs pexpect base58 web3 voluptuous robonomics_comm_ethereum_common ];

  meta = with stdenv.lib; {
    description = "Robonomics lighthouse support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
