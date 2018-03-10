{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosmake";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0fr1a2r2j5gz2l9nfy9ajnn70gw9mmrl14k6ch9kn554iskyj99a";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "ROS dependency aware build tool which can be used to build all dependencies in the correct order";
    homepage = http://wiki.ros.org/rosmake;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
