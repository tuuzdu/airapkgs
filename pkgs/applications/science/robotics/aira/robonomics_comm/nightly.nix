{ stdenv
, ros_comm
, mkRosPackage
, python3Packages
, fetchFromGitHub
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "robonomics_comm-nightly";
  version = "7279b38f";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "7279b38f02152b4707cda2732d3afc462d65a3a6";
    sha256 = "1gxfm4lxk9sbx0xsai03szkf4mj31gnhn08mrf2pp88p4khxz51b";
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm web3 multihash voluptuous ipfsapi python-persistent-queue ];

  meta = with stdenv.lib; {
    description = "Robonomics communication stack";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
