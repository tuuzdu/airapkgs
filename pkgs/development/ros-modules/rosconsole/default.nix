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
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "06sjhlx8cs4xmcxgwnw7jxs5xgzpjs31n6fsjbrxz659dw234al3";
  };

  propagatedBuildInputs = [ catkin boost cpp_common log4cxx rosbuild rostime rosunit ];

  meta = with stdenv.lib; {
    description = "ROS console output library";
    homepage = http://wiki.ros.org/rosconsole;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
