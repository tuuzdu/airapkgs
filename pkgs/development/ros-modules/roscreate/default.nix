{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "roscreate";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "05yp740l58mw3dlaw09668avlr0i992j0i0bfcbvd8hll3imbg0n";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "";
    homepage = http://wiki.ros.org/roscreate;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
