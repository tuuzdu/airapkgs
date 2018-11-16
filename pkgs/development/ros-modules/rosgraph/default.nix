{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, python3Packages
}:

let
  pname = "rosgraph";
  version = "1.14.4";
  rosdistro = "melodic";


in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1n4smqb0j2yjrinj13j7wc43mysrl9ivya7wv6qg8fbbpx6s1xdc";
  };

  propagatedBuildInputs = [ catkin python3Packages.netifaces ];

  meta = with stdenv.lib; {
    description = "Command-line tool, which prints information about the ROS Computation Graph";
    homepage = http://wiki.ros.org/rosgraph;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
