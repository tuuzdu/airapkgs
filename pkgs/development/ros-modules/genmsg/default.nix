{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "genmsg";
  version = "0.5.11";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "04ya9x910yvbpk883y3cpw2kmbkg8l8hl808sh79cyk4ff6hd0wf";
  };

  propagatedBuildInputs = [ catkin ];

  postPatch = ''
    sed -i 's/''${PYTHON_EXECUTABLE} ''${GENMSG_CHECK_DEPS_SCRIPT}/''${GENMSG_CHECK_DEPS_SCRIPT}/' ./cmake/pkg-genmsg.cmake.em
  '';

  meta = with stdenv.lib; {
    description = "Standalone Python library for generating ROS message and service data structures for various languages";
    homepage = http://wiki.ros.org/genmsg;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
