{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
, mavros
, python3Packages
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "gscn_pioneer_mission";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "tuuzdu";
    repo = "${pname}";
    rev = "master";
    sha256 = "0ckp82f6wv5q6xkb9wzj68a3vnvb25v5pzldigflfzps3p74mxfy";
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm mavros ];

  meta = with stdenv.lib; {
    description = "Pioneer test mission";
    homepage = http://github.com/tuuzdu/gscn_pioneer_mission;
    license = licenses.bsd3;
    maintainers = [ maintainers.tuuzdu ];
  };
}
