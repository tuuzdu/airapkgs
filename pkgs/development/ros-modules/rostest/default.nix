{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosgraph
, roslaunch
, rosmaster
, rospy
, rosunit
}:

let
  pname = "rostest";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0n33dz7p2h9wpxmwry3p486jbwq8c3akjdzqgx6l83mb1yxg98fv";
  };

  propagatedBuildInputs = [ catkin rosgraph roslaunch rosmaster rospy rosunit ];

  meta = with stdenv.lib; {
    description = "Integration test suite based on roslaunch that is compatible with xUnit frameworks";
    homepage = http://wiki.ros.org/rostest;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
