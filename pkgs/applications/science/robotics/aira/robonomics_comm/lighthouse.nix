{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
, python3Packages
, ipfs
, robonomics_comm_ethereum_common
, robonomics_comm_msgs
}:

let
  pname = "robonomics_lighthouse";
  version = "0.6.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "1xrxgxxzfrnn56vy1zd437bq3y47fcffial9sm9yhihyaxysr3ai";
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm ipfs pexpect base58 web3 voluptuous
    robonomics_comm_ethereum_common robonomics_comm_msgs ];

  meta = with stdenv.lib; {
    description = "Robonomics lighthouse support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
