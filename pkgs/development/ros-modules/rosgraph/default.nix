{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, python3Packages
}:

let
  pname = "rosgraph";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "18yz5wwc8l16zc7n7jxj5qq7bpby00wmdvf1687dw8qrq3nlxqq6";
  };

  propagatedBuildInputs = [ catkin python3Packages.netifaces ];

  meta = with stdenv.lib; {
    description = "Command-line tool, which prints information about the ROS Computation Graph";
    homepage = http://wiki.ros.org/rosgraph;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
