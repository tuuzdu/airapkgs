{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosbuild
, rosgraph
, roslaunch
, roslib
, rosnode
, rosservice
, rostest
}:

let
  pname = "roswtf";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "057zpghy8vdnqxacaz9zq7s8rbyjy1qa9ynf6mh5dnyidl7861hd";
  };

  propagatedBuildInputs = [ catkin rosbuild rosgraph roslaunch roslib rosnode rosservice rostest ];

  meta = with stdenv.lib; {
    description = "Tool for diagnosing issues with a running ROS system";
    homepage = http://wiki.ros.org/roswtf;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
