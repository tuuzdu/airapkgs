{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
, message_generation
, message_runtime
, rosconsole
, roscpp_serialization
, roscpp_traits
, rosgraph_msgs
, roslang
, rostime
, std_msgs
, xmlrpcpp
}:

let
  pname = "roscpp";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "12rkyhk92xh2pgq27mpsvmwn3zsns31scfvnmzdflh8mgrwygrrs";
  };

  propagatedBuildInputs =
  [ catkin cpp_common message_generation message_runtime
    rosconsole roscpp_serialization roscpp_traits rosgraph_msgs
    roslang rostime std_msgs xmlrpcpp ];

  meta = with stdenv.lib; {
    description = "C++ implementation of ROS client library";
    homepage = http://wiki.ros.org/roscpp;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
