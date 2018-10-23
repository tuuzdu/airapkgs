{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
}:

let
  pname = "robonomics_msgs";
  version = "0.0.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${name}";
    sha256 = "0dq3vaijqvcw3r7wx1ab4cl9w713dq7fdvacl6hyxskh2hx2m22j";
  };

  propagatedBuildInputs = [ ros_comm ];

  meta = with stdenv.lib; {
    description = "Robonomics communication messages";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
