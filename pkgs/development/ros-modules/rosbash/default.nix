{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosbash";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "16rpma98ggck93cx73w6kgchd5zq59dgy81601f5dznf77ksipx4";
  };

  propagatedBuildInputs = [ catkin ];

  patchPhase = ''
    sed -i 's|_perm="+111"|_perm="/111"|' ./scripts/rosrun
  '';

  meta = with stdenv.lib; {
    description = "Assorted shell commands for using ros with bash";
    homepage = http://wiki.ros.org/rosbash;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
