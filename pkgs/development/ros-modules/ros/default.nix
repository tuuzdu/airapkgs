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
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1zvm652m90fq2wzpl1s6ay45z6sbv2pgbx6wfz47kshvvs4yd2w3";
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
