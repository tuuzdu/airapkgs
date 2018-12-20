{ stdenv
, robonomics_comm
, rosserial
, mkRosPackage
, fetchFromGitHub
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "robonomics_tutorials";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    rev = "v${version}";
    sha256 = "07zzkypy8mci8z59fzcads4zixlcfm1xm050y11fzxhc5815bq9q";
  };

  propagatedBuildInputs = [ robonomics_comm rosserial ];

  meta = with stdenv.lib; {
    description = "Robonomics tutorials stack";
    homepage = http://github.com/airalab/robonomics_tutorials;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
