{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake_modules
, boost
, tinyxml-2
}:

let
  pname = "rospack";
  version = "2.4.4";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "rospack-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1a2wvpqz3qlz6h809f0v5chxbngxhql21kxkqbhpmpnfrl1grba5";
  };

  propagatedBuildInputs = [ catkin cmake_modules boost tinyxml-2 ];

  meta = with stdenv.lib; {
    description = "ROS Package Tool";
    homepage = http://wiki.ros.org/rospack;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
