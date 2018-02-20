{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, genpy
, roscpp
, rosgraph
, rosgraph_msgs
, roslib
, std_msgs
}:

let
  pname = "rospy";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "03gm4khik8s80diph826r1wjsdqfrgfky9cxfzzmjb0zd7qgj60d";
  };

  propagatedBuildInputs = [ catkin genpy roscpp rosgraph rosgraph_msgs roslib std_msgs ];

  meta = with stdenv.lib; {
    description = "Python client library for ROS";
    homepage = http://wiki.ros.org/rospy;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
