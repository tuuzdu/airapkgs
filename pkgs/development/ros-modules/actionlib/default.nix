{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, actionlib_msgs
, message_generation
, roscpp
, rosunit
, rostest
, std_msgs
}:

let
  pname = "actionlib";
  version = "1.11.11";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1cg1mzrpp55dfqii5jivh02304c76pr7rgd2d46yqkiw2rg8if2b";
  };

  propagatedBuildInputs =
  [ catkin actionlib_msgs message_generation roscpp rosunit rostest std_msgs ];

  meta = with stdenv.lib; {
    description = "Standardized interface for interfacing with preemptable tasks";
    homepage = http://wiki.ros.org/actionlib;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
