{ stdenv
, mkRosPackage
, fetchFromGitHub
, python3Packages
, catkin
}:

let
  pname = "mavlink";
  version = "2018.7.18";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "${pname}";
    repo = "${pname}-gbp-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0bvmaj5ndj73d1k9kaj5kichx4d1cx0s11w59swj8xxgcv9z62l3";
  };

  buildInputs = with python3Packages; [ catkin future ];

  postPatch = ''
    substituteInPlace CMakeLists.txt --replace "/usr/bin/env" "env"
  '';

  meta = with stdenv.lib; {
    description = "Marshalling / communication library for drones.";
    homepage = https://github.com/mavlink/mavlink;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru ];
  };
}
