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
    sha256 = "1w1q9lph0x1h2bpj4l1g7453hkrvdlpgi7aqwbvd9nf2360nadf8";
  };

  propagatedBuildInputs = [ robonomics_comm rosserial ];

  meta = with stdenv.lib; {
    description = "Robonomics tutorials stack";
    homepage = http://github.com/airalab/robonomics_tutorials;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
