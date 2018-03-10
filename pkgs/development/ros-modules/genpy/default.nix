{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, genmsg
, python3Packages
}:

let
  pname = "genpy";
  version = "0.6.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1rhmni7l1iwdkkb3wp3l3c8rrhrq27zj39zlkmdrd1f7isis3ijb";
  };

  propagatedBuildInputs = [ catkin genmsg python3Packages.pyyaml ];

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
