{ stdenv
, mkRosPackage
, fetchFromGitHub
, genmsg
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "gencpp";
  version = "0.6.0";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1wjizls8h2qjjq8aliwqvxd86p2jzll4cq66grzf8j7aj3dxvyl2";
  };

  propagatedBuildInputs = [ genmsg ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/gencpp-extras.cmake.em
  '';

  meta = with stdenv.lib; {
    description = "C++ ROS message and service generators";
    homepage = http://wiki.ros.org/gencpp;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
