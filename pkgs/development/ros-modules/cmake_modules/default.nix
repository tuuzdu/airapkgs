{ stdenv
, mkRosPackage
, fetchFromGitHub
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "cmake_modules";
  version = "0.4.1";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1z85gmadn5llnzabkkij2l5xf39mxc48v8i4m08vnpnljzr06x0i";
  };

  meta = with stdenv.lib; {
    description = "A common repository for CMake Modules for ROS";
    homepage = http://wiki.ros.org/cmake_modules;
    license = licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.akru ];
  };
}
