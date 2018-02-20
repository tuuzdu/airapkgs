{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosgraph
}:

let
  pname = "rosmaster";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0w738zfvhqcizpm613niblsrs0c0wwjb1hss1r9n1kqpp5qrh7m8";
  };

  propagatedBuildInputs = [ catkin rosgraph ];

  meta = with stdenv.lib; {
    description = "ROS Master implementation";
    homepage = http://wiki.ros.org/rosmaster;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
