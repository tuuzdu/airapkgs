{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, std_msgs
}:

let
  pname = "actionlib_msgs";
  version = "1.12.5";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "common_msgs-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0927xymm16b6dwyp3rpr5ig0ppiljnlmyjwf6nb96lb6ywifdznc";
  };

  propagatedBuildInputs = [ catkin message_generation std_msgs ];

  meta = with stdenv.lib; {
    description = "Common messages to interact with an action server and an action client";
    homepage = http://wiki.ros.org/actionlib_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
