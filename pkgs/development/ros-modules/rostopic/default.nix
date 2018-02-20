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
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1r9hjmn47n2pmhbr0la3b4g6c0d4myww50z9m8x5dbl347kbqc7q";
  };

  propagatedBuildInputs = [ catkin genpy rosbag rospy rostest ];

  meta = with stdenv.lib; {
    description = "Command-line tool for displaying debug information about ROS Topics";
    homepage = http://wiki.ros.org/rostopic;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
