{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosclean";
  version = "1.14.4";
  rosdistro = "melodic";
  
in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "10k6ld40nh3f09nqy54qdayxf915x3vyf9la8ky3jk7f2i8qzm1c";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Cleanup filesystem resources (e.g. log files)";
    homepage = http://wiki.ros.org/rosclean;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
