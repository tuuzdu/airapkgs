{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
, python3Packages
, ipfs
}:

let
  pname = "robonomics_market";
  version = "0.0.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${pname}-0";
    sha256 = "1vckxjs4mvplsq30k4bwdz8g1cmj686zj4bnxs8z53h3kl9cn19n";
  };

  propagatedBuildInputs = with python3Packages; [ ros_comm ipfs pexpect base58 web3 ];

  meta = with stdenv.lib; {
    description = "Robonomics market support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
