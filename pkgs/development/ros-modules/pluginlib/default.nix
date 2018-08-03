{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, class_loader
, rosconsole
}:

let
  pname = "pluginlib";
  version = "1.12.1";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "06knk7hk17xhblf2g59czjhgk81wjrd8fcws6rj564p8jp9l7b4h";
  };

  propagatedBuildInputs = [ catkin class_loader rosconsole ];

  meta = with stdenv.lib; {
    description = "Tools for writing and dynamically loading plugins using the ROS build infrastructure.";
    homepage = http://wiki.ros.org/pluginlib;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
