{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
}:

let
  pname = "rostime";
  version = "0.6.9";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0s64glcxsib3wliwr8qfr08k8bkjcg11g740jw78krn1bkwzj5x6";
  };

  propagatedBuildInputs = [ catkin cpp_common ];

  meta = with stdenv.lib; {
    description = "Time and Duration implementations for C++ libraries";
    homepage = http://wiki.ros.org/rostime;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
