{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
, python3Packages
, ipfs
}:

let
  pname = "robonomics_lighthouse";
  version = "0.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${pname}-${version}";
    sha256 = "1fx6sri746im213fz8hra0kjy2g0mn9ipld6840mqnjh5m68ahh5";
  };

  propagatedBuildInputs = with python3Packages; [ ros_comm ipfs pexpect base58 web3 ];

  meta = with stdenv.lib; {
    description = "Robonomics lighthouse support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
