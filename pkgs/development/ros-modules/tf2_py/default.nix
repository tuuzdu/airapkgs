{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rospy
, tf2
}:

let
  pname = "tf2_py";
  version = "0.5.18";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "geometry2-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0p01sjirj43vdznv4mh4lzz9nq836qwvnqw9mr1pbajsp4wg7gkf";
  };

  propagatedBuildInputs = [ catkin tf2 rospy ];

  meta = with stdenv.lib; {
    description = "Binds the tf2 functions and exceptions to python.";
    homepage = http://wiki.ros.org/tf2_py;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
