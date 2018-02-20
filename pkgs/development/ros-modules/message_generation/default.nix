{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, genmsg
, gencpp
, genpy
}:

let
  pname = "message_generation";
  version = "0.4.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0vnwr3jx0dapmyqgiy7h4qxkf837cv1wacqpxm5j10c864vmcrb3";
  };

  propagatedBuildInputs = [ catkin genmsg gencpp genpy ];

  postPatch = ''
    sed -i 's/geneus gennodejs genlisp //g' CMakeLists.txt
  '';

  meta = with stdenv.lib; {
    description = "Package modeling the build-time dependencies for generating language bindings of messages";
    homepage = http://wiki.ros.org/message_generation;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
