{ stdenv
, robonomics_comm
, rosserial
, mkRosPackage
, fetchFromGitHub
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "robonomics_tutorials";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    rev = "v${version}";
    sha256 = "14vbnnyrz394wnlp2m9zbav0izpadpgqb0h7s2pvzk6jrbc21zpz";
  };

  propagatedBuildInputs = [ robonomics_comm rosserial ];

  meta = with stdenv.lib; {
    description = "Robonomics tutorials stack";
    homepage = http://github.com/airalab/robonomics_tutorials;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
