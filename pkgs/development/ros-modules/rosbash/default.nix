{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosbash";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0y7zkrfya3i1vzqsfmpgwjhiglavkm5sk70lk7gpng19g9f8psp8";
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
