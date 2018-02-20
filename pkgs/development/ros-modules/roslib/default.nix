{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rospack
}:

let
  pname = "roslib";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1qnwclzym3shvf68vls6nxaxsdkh0cl3c5q20446c4j5shfj3gx6";
  };

  propagatedBuildInputs = [ catkin rospack ];

  meta = with stdenv.lib; {
    description = "Base dependencies and support libraries for ROS";
    homepage = http://wiki.ros.org/roslib;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
