{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
}:

let
  pname = "rosbuild";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0npnkkfyr5nrxr1g9kak1i2cjc6vmz87v1p89901yawcl1g8hkix";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime ];

  meta = with stdenv.lib; {
    description = "Contains scripts for managing the CMake-based build system for ROS";
    homepage = http://wiki.ros.org/rosbuild;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
