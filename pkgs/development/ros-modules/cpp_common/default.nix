{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, boost
, console_bridge
}:

let 
  pname = "cpp_common";
  version = "0.6.9";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1yay8vhr0hwilz0rjnhjhyjrcjwyzrig78imji1dxkwaf655rw2g";
  };

  propagatedBuildInputs = [ catkin boost console_bridge ];

  meta = with stdenv.lib; {
    description = "C++ code for doing things that are not necessarily ROS related";
    homepage = http://wiki.ros.org/cpp_common;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
