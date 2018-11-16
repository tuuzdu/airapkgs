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
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "17nqv4i54s5wsx9nsmn3q2yr88rfmdhvz1sg91fdl79wg7w6vq00";
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
