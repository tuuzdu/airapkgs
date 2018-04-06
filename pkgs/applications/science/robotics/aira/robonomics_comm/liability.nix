{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_lighthouse
, python3Packages
}:

let
  pname = "robonomics_liability";
  version = "0.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "1qqycrgnk5y4c26ddqw2zfga48rkyyfiq40c8h130pvlphad84j7";
  };

  propagatedBuildInputs = with python3Packages; [ robonomics_comm_lighthouse web3 ipfsapi ];

  meta = with stdenv.lib; {
    description = "Robot liability support for ROS";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
