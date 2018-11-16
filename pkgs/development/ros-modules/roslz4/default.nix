{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, lz4
}:

let
  pname = "roslz4";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1f3ar4jpmmv9w8rgf4hdyp4vdhly01ym3pc2faaacf6lcyxzrmcn";
  };

  propagatedBuildInputs = [ catkin lz4 ];

  meta = with stdenv.lib; {
    description = "A Python and C++ implementation of the LZ4 streaming format";
    homepage = http://wiki.ros.org/roslz4;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
