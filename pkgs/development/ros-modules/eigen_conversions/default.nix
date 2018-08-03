{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, orocos_kdl
, geometry_msgs
, eigen
}:

let
  pname = "eigen_conversions";
  version = "1.12.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "geometry-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "17fz7dpn8m300bdb8xmx5mpld35i19psyr9nksv4qxxa1f6rxgr4";
  };

  propagatedBuildInputs = [ catkin orocos_kdl geometry_msgs eigen ];

  # https://stackoverflow.com/questions/12249140/find-package-eigen3-for-cmake
  preConfigure = ''
    sed -i 's/find_package(Eigen3 REQUIRED)//g' CMakeLists.txt
  '';

  meta = with stdenv.lib; {
    description = "Conversion functions between: - Eigen and KDL - Eigen and geometry_msgs.";
    homepage = http://wiki.ros.org/eigen_conversions;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
