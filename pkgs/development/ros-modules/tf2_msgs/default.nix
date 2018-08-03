{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, geometry_msgs
, actionlib_msgs
}:

let
  pname = "tf2_msgs";
  version = "0.5.18";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "geometry2-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0whqmcza7ydc30vlfpk826hy0g22splisx8b58nhin7dwxxbxm36";
  };

  propagatedBuildInputs = [ catkin actionlib_msgs geometry_msgs ];

  meta = with stdenv.lib; {
    description = "ROS bindings for the tf2 library, for both Python and C++.";
    homepage = http://wiki.ros.org/tf2_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
