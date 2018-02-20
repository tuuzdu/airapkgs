{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake_modules
, boost
, tinyxml-2
}:

let
  pname = "rospack";
  version = "2.4.4";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "rospack-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0m7sa75777w9q45b39gr89fsxl5jmfglpy1qi9yfgcb1hig861gl";
  };

  propagatedBuildInputs = [ catkin cmake_modules boost tinyxml-2 ];

  meta = with stdenv.lib; {
    description = "ROS Package Tool";
    homepage = http://wiki.ros.org/rospack;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
