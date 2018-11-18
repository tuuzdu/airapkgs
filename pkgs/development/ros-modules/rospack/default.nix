{ stdenv
, mkRosPackage
, fetchFromGitHub
, cmake_modules
, boost
, tinyxml-2
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "rospack";
  version = "2.5.2";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "rospack-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1a2wvpqz3qlz6h809f0v5chxbngxhql21kxkqbhpmpnfrl1grba5";
  };

  buildInputs = [ boost tinyxml-2 ];
  propagatedBuildInputs = [ cmake_modules ];

  meta = with stdenv.lib; {
    description = "ROS Package Tool";
    homepage = http://wiki.ros.org/rospack;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
