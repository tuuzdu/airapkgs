{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, boost
, cpp_common
, log4cxx
, rosbuild
, rostime
, rosunit
}:

let
  pname = "rosconsole";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1w2wy6pi5vqd3dkdv7nq7q4wipbicl2iwf9ccipj10fzf3n7jwq3";
  };

  propagatedBuildInputs = [ catkin boost cpp_common log4cxx rosbuild rostime rosunit ];

  meta = with stdenv.lib; {
    description = "ROS console output library";
    homepage = http://wiki.ros.org/rosconsole;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
