{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
, rostime
}:

let
  pname = "roscpp_traits";
  version = "0.6.9";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "10fm5wkv3x91xzvdg2zf1afk29kzs8ivd2g3x5ccbmllhhl6vww0";
  };

  propagatedBuildInputs = [ catkin cpp_common rostime ];

  meta = with stdenv.lib; {
    description = "Contains the message traits code, is a component of roscpp";
    homepage = http://wiki.ros.org/roscpp_traits;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
