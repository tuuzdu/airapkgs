{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_filters
, ros
, rosbag
, rosconsole
, roscpp
, rosgraph
, rosgraph_msgs
, roslaunch
, rosmaster
, rosmsg
, rosnode
, rosout
, rosparam
, rospy
, rosservice
, rostest
, rostopic
, roswtf
, std_srvs
, topic_tools
, xmlrpcpp
}:

let
  pname = "ros_comm";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1scbxsilx3xrv5lk57nk2crw8cchh0yp1216bmphyqjfp9vi987r";
  };

  propagatedBuildInputs =
  [ catkin message_filters ros rosbag rosconsole roscpp
    rosgraph rosgraph_msgs roslaunch rosmaster rosmsg rosnode
    rosout rosparam rospy rosservice rostest rostopic roswtf
    std_srvs topic_tools xmlrpcpp ];

  meta = with stdenv.lib; {
    description = "ROS communications-related packages, including core client libraries";
    homepage = http://wiki.ros.org/ros_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
