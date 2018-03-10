{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosclean
, rosgraph_msgs
, roslib
, rosmaster
, rosout
, rosparam
, rosunit
, python3Packages
}:

let
  pname = "roslaunch";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "08rz1xxj7703sqrnfa8sww6jxm0k8jx10c7qsa23c3m63v0gm06n";
  };

  propagatedBuildInputs = [ catkin rosclean rosgraph_msgs roslib
                            rosmaster rosout rosparam rosunit python3Packages.defusedxml ];

  meta = with stdenv.lib; {
    description = "Tool for easily launching multiple ROS nodes";
    homepage = http://wiki.ros.org/roslaunch;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
