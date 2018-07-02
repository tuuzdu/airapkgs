{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
}:

let
  pname = "rostime";
  version = "0.6.11";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0500gr9y1vrwbhx2ihnyaprys7svpg2hxkk191y3x5b969lc8ibm";
  };

  propagatedBuildInputs = [ catkin cpp_common ];

  meta = with stdenv.lib; {
    description = "Time and Duration implementations for C++ libraries";
    homepage = http://wiki.ros.org/rostime;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
