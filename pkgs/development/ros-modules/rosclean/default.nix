{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosclean";
  version = "1.14.1";
  
in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1pv3wfdmjbyrchyznnh1qxhybm9l14hwacqzz8gigc584wa76ivz";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Cleanup filesystem resources (e.g. log files)";
    homepage = http://wiki.ros.org/rosclean;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
