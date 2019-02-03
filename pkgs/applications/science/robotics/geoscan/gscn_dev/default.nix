{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, ros_comm
, mavros
, python3Packages
}:

let
  pname = "gscn_dev";
  version = "0.0.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "tuuzdu";
    repo = "de_dev";
    rev = "gscn";
    sha256 = "1asvajgf2awqw24dd6nazvpbv9i2q4x45p29fl7r7ir5xy7bl1k1";
  };

  propagatedBuildInputs = with python3Packages;
  [ catkin ros_comm mavros
  ];

  meta = with stdenv.lib; {
    description = "Geoscan development kit";
    homepage = http://github.com/tuuzdu/de_dev;
    license = licenses.bsd3;
    maintainers = [ maintainers.tuuzdu ];
  };
}
