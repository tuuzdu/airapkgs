{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "roslang";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "18p5ncr4qq3shhmrf3zsmx7sqpzli2n2k9lbb1s64fqljcwnzkd1";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Common package that all ROS client libraries depend on";
    homepage = http://wiki.ros.org/roslang;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
