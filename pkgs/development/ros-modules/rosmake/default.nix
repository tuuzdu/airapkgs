{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosmake";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0kk49a5xmlp4dv90rzf22kz5yjn4dw67lny6rss2qsanpr01zgmy";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "ROS dependency aware build tool which can be used to build all dependencies in the correct order";
    homepage = http://wiki.ros.org/rosmake;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
