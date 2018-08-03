{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, console_bridge
, rosconsole
}:

let
  pname = "rosconsole_bridge";
  version = "0.5.1";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1l733r4zd6417k5alk921hbrz6xnk98rvfdvm9llpd4dihf01hj8";
  };

  propagatedBuildInputs = [ catkin console_bridge rosconsole ];

  meta = with stdenv.lib; {
    description = "ROS console output library";
    homepage = http://wiki.ros.org/rosconsole_bridge;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
