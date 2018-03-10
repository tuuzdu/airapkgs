{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, lz4
}:

let
  pname = "roslz4";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1gffgknj3msb8n57pd31h3nly6rz2z7ymm660mxqmj7b4kfbdlbv";
  };

  propagatedBuildInputs = [ catkin lz4 ];

  meta = with stdenv.lib; {
    description = "A Python and C++ implementation of the LZ4 streaming format";
    homepage = http://wiki.ros.org/roslz4;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
