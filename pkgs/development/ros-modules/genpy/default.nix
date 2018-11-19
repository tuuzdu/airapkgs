{ stdenv
, mkRosPackage
, fetchFromGitHub
, genmsg
, python3Packages
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "genpy";
  version = "0.6.7";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1mvyiwn98n07nfsd2igx8g7laink4c7g5f7g1ljqqpsighrxn5jd";
  };

  propagatedBuildInputs = with python3Packages; [ genmsg pyyaml ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/genpy-extras.cmake.em
  '';

  meta = with stdenv.lib; {
    description = "Python ROS message and service generators";
    homepage = http://wiki.ros.org/genpy;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
