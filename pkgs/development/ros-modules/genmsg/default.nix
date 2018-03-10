{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "genmsg";
  version = "0.5.10";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "049s3s3yr986j5z35grq9hx3rxyj3fjar5iqcxlzlw2q5mqma70y";
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
