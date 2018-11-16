{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, genpy
, rosbag
, rospy
, rostest
}:

let
  pname = "rostopic";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "10vnn8pvcsav1hzarsv8nqfd57z63lfhhc3fcxhjf76yg2p1nv1q";
  };

  propagatedBuildInputs = [ catkin genpy rosbag rospy rostest ];

  meta = with stdenv.lib; {
    description = "Command-line tool for displaying debug information about ROS Topics";
    homepage = http://wiki.ros.org/rostopic;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
