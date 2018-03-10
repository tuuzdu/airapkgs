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
  version = "0.6.9";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0icmczncfwy3d5b51wvmz3cy3qlb7zs72x5li7k99ldv01jri6pa";
  };

  propagatedBuildInputs = [ catkin cpp_common rostime roscpp_traits ];

  meta = with stdenv.lib; {
    description = "Contains the code for serialization, is a component of roscpp";
    homepage = http://wiki.ros.org/roscpp_serialization;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
