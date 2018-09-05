{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_lighthouse
, python3Packages
, ros_comm
}:

let
  pname = "ethereum_common";
  version = "0.1";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "0rhgk8mnzw479q6yx4q7klisscfs9gszmirnbdycq9rb7nh69k1x";
  };

  propagatedBuildInputs = with python3Packages; [ ros_comm web3 ];

  meta = with stdenv.lib; {
    description = "Commonly used Ethereum communication nodes";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
