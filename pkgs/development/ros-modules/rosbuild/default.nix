{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
}:

let
  pname = "rosbuild";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0xarzviz72yihmngy0wjz1lkra4xgx5zr11ddqw2xvsca8xsa4kw";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime ];

  meta = with stdenv.lib; {
    description = "Contains scripts for managing the CMake-based build system for ROS";
    homepage = http://wiki.ros.org/rosbuild;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
