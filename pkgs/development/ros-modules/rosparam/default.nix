{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosgraph
}:

let
  pname = "rosparam";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0b9gl8ril21x1ccnvwjimyrj4cq3cglsjhmkagrbdcw2vwrsd9js";
  };

  propagatedBuildInputs = [ catkin rosgraph ];

  meta = with stdenv.lib; {
    description = "Command-line tool for getting and setting ROS Parameters";
    homepage = http://wiki.ros.org/rosparam;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
