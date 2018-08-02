{ stdenv
, mkRosPackage
, fetchurl 
, pkgconfig
, catkin
, eigen
}:

let
  pname = "orocos_kdl";
  version = "1.3.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/smits/orocos-kdl-release/archive/release/kinetic/orocos_kdl/1.3.0-0.tar.gz";
    sha256 = "04dakl1vw5ablpis0wkqslii7hji5hdv9f4x35wdgwz325arwl8z";
  };

  propagatedBuildInputs = [ catkin eigen pkgconfig ];

  preConfigure = ''
    sed -i 's|FIND_PATH(EIGEN3_INCLUDE_DIR Eigen/Core |FIND_PATH(EIGEN3_INCLUDE_DIR Eigen/Core ${eigen}/include/eigen3 |' ./config/FindEigen3.cmake
  '';

  meta = with stdenv.lib; {
    description = "Kinematics and Dynamics Library";
    homepage = http://wiki.ros.org/orocos_kdl;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
