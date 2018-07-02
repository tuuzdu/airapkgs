{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
, rostime
, roscpp_traits
}:

let
  pname = "roscpp_serialization";
  version = "0.6.11";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1rgw9xvnbc64gbxc7aw797hbq49v1ql783msyf2njda4fcmwzwpp";
  };

  propagatedBuildInputs = [ catkin cpp_common rostime roscpp_traits ];

  meta = with stdenv.lib; {
    description = "Contains the code for serialization, is a component of roscpp";
    homepage = http://wiki.ros.org/roscpp_serialization;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
