{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, console_bridge
, tf2_msgs
}:

let
  pname = "tf2";
  version = "0.5.18";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "geometry2-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "07iq5c1yy3k3hy5a383xrwl91fb7518jlvafj9wccngysw069r7x";
  };

  propagatedBuildInputs = [ catkin console_bridge tf2_msgs ];

  meta = with stdenv.lib; {
    description = "ROS bindings for the tf2 library, for both Python and C++.";
    homepage = http://wiki.ros.org/tf2;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
