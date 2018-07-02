{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
, rostime
}:

let
  pname = "roscpp_traits";
  version = "0.6.11";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0pgwzd2yzsqfap80n6wcnj0jip1z3cghw49mihyf8w0q3lfz6yf6";
  };

  propagatedBuildInputs = [ catkin cpp_common rostime ];

  meta = with stdenv.lib; {
    description = "Contains the message traits code, is a component of roscpp";
    homepage = http://wiki.ros.org/roscpp_traits;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
