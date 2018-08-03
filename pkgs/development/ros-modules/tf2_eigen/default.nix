{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake_modules
, tf2
, eigen
}:

let
  pname = "tf2_eigen";
  version = "0.5.18";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "geometry2-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0zi39f8cqy45rjwk7lf7gjv7bkzz9n5y6qpnrqmsncz4k60kls7q";
  };

  propagatedBuildInputs = [ catkin cmake_modules tf2 eigen ];

  meta = with stdenv.lib; {
    description = "Convert tf2 data to eigen data structures.";
    homepage = http://wiki.ros.org/tf2_eigen;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
