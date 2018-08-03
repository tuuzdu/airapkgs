{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, actionlib
, message_filters
, tf2_py
}:

let
  pname = "tf2_ros";
  version = "0.5.18";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "geometry2-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0hgwnin3bg914f8jimg5bnzxswcl8qw2jv8cp4h2iij3ampjdzha";
  };

  propagatedBuildInputs = [ catkin actionlib message_filters tf2_py ];

  meta = with stdenv.lib; {
    description = "ROS bindings for the tf2 library, for both Python and C++.";
    homepage = http://wiki.ros.org/tf2_ros;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
