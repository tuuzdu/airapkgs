{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, genmsg
}:

let
  pname = "gencpp";
  version = "0.5.5";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1x3kf64yywc9d2s071i8hizgqkv38r2dpz1gs8qk916r8yizsa7f";
  };

  propagatedBuildInputs = [ catkin genmsg ];

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
