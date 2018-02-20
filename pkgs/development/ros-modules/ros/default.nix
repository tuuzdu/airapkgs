{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosbash
, rosboost_cfg
, rosbuild
, rosclean
, roscreate
, roslang
, roslib
, rosmake
, rosunit
}:

let
  pname = "ros";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0rjpfmdcqnpxy0w2iyacn547ix7h4fh4h8jcvxm0hx58zfvfpzqk";
  };

  propagatedBuildInputs = [ catkin rosbash rosboost_cfg rosbuild rosclean
                            roscreate roslang roslib rosmake rosunit ];

  meta = with stdenv.lib; {
    description = "ROS packaging system";
    homepage = http://wiki.ros.org/ros;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
