{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "roslang";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "04hj3qv0gyc9ld0pyxjmw54y6jxag5x5dg864zc1jah09mz3sxvh";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Common package that all ROS client libraries depend on";
    homepage = http://wiki.ros.org/roslang;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
