{ stdenv
, fetchFromGitHub
, python3Packages
, python3
, cmake
}:

let
  pname = "catkin";
  version = "0.7.14";
  rosdistro = "melodic";

in stdenv.mkDerivation {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0dhfm1mya467dv6qc6j86f0yxbwqgvf2319p2r6bpvngjby51d86";
  };
  
  cmakeFlags = "-DCATKIN_ENABLE_TESTING=OFF -DSETUPTOOLS_DEB_LAYOUT=OFF";

  propagatedBuildInputs = with python3Packages; [ catkin_pkg rospkg empy cmake ];

  patchPhase = ''
    sed -i 's/PYTHON_EXECUTABLE/SHELL/' ./cmake/catkin_package_xml.cmake
    sed -i 's|#!/usr/bin/env bash|#!${stdenv.shell}|' ./cmake/templates/setup.bash.in
    sed -i 's|#!/usr/bin/env sh|#!${stdenv.shell}|' ./cmake/templates/setup.sh.in
    sed -i 's|#!/usr/bin/env python|#!${python3.interpreter}|' ./cmake/parse_package_xml.py
  '';

  meta = with stdenv.lib; {
    description = "A CMake-based build system that is used to build all packages in ROS";
    homepage = http://wiki.ros.org/catkin;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
