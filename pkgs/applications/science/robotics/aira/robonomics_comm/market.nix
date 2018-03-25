{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
, python3Packages
, ipfs
}:

let
  pname = "robonomics_market";
  version = "0.1.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${pname}-1";
    sha256 = "1r17jjjrf8341k8r66wh4n64ps4blg9c3k5p3v75acw6gmqi5bj9";
  };

  propagatedBuildInputs = with python3Packages; [ ros_comm ipfs pexpect base58 web3 ];

  meta = with stdenv.lib; {
    description = "Robonomics market support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
