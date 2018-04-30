{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_lighthouse
, python3Packages
, ros_comm
}:

let
  pname = "ethereum_common";
  version = "0.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "1i1kh4wxn73n0m6q2ckps31034pw9jzl732q157nsjyy8x3as5wf";
  };

  propagatedBuildInputs = with python3Packages; [ ros_comm web3 ];

  meta = with stdenv.lib; {
    description = "Commonly used Ethereum communication nodes";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
