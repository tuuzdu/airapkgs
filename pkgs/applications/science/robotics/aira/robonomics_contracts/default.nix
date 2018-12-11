{ stdenv, lib, makeWrapper, fetchFromGitHub, buildEnv, fetchurl, nodejs, pkgs }:

with lib;

let
  nodePackages = import ./node.nix {
    inherit pkgs;
    system = stdenv.hostPlatform.system;
  };

  runtimeEnv = buildEnv {
    name = "robonomics_contracts-runtime";
    paths = with nodePackages; [
          nodePackages.chai
          nodePackages.bn-chai
          nodePackages.chai-as-promised
          nodePackages.eth-gas-reporter
          nodePackages.eth-ens-namehash
          nodePackages.openzeppelin-solidity
          nodePackages."ganache-cli-7.0.0-beta.0"
          nodePackages."truffle-5.0.0-beta.2"
          nodePackages.truffle-flattener
    ];
  };

in stdenv.mkDerivation rec {

  pname = "robonomics_contracts";
  version = "1.0.0-rc2";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
      owner = "airalab";
      repo = "robonomics_contracts";
      rev = "31edea278a86425fdea12c9ba753c07b3d2d7e8e";
      sha256 = "1pqjf681r9swb67x34z97xdmzdy6z3g408n0f6ps2fpyz64shq06";
  };

  buildInputs = [ makeWrapper nodejs ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    cp -R . $out

    #copy files
    cp -RL ${runtimeEnv}/lib/node_modules $out

    cat >$out/bin/truffle <<EOF
      #!${stdenv.shell}/bin/sh
      pushd $out
      ${nodejs}/bin/node $out/node_modules/.bin/truffle --contracts_build_directory /tmp/contracts/ "\$@"
    EOF
  '';

  postFixup = ''
    chmod +x $out/bin/truffle

    wrapProgram $out/bin/truffle \
      --set NODE_PATH "$out/node_modules/truffle/node_modules/"

    pushd $out
    export HOME=$TMPDIR # fix tests failing in sandbox due to "/homeless-shelter"
    export NODE_PATH="$out/node_modules/truffle/node_modules"
    ${nodejs}/bin/node $out/node_modules/.bin/truffle compile
  '';

  meta = with stdenv.lib; {
    description = "Robonomics platform smart contracts";
    homepage = http://github.com/airalab/robonomics_contracts;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.strdn ];
  };

}
