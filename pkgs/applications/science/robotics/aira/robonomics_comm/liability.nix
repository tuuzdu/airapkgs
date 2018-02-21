{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_market
, python3Packages
}:

let
  pname = "robonomics_liability";
  version = "0.0.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${pname}-0";
    sha256 = "15sfx7ffjwfy0q7448847sclhibd6ysaya7dbywxny6s9id8q9gs";
  };

  propagatedBuildInputs = with python3Packages; [ robonomics_comm_market web3 ipfsapi ];

  meta = with stdenv.lib; {
    description = "Robot liability support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
