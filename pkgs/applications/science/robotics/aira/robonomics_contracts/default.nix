{ stdenv
, fetchFromGitHub
, pkgs
, makeWrapper
, nodejs-8_x
, buildEnv
}:

let
  nodePackages = import ./node.nix { inherit pkgs; };
  nodeEnv = buildEnv {
    name = "robonomics_contracts-env";
    paths = stdenv.lib.attrValues nodePackages;
  };

in stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "robonomics_contracts";
  version = "1.0-rc2";

  src = fetchFromGitHub {
      owner = "airalab";
      repo = pname;
      rev = "2da5bbe6d5b65ad45cb78566600f2c86b7cd64ff";
      sha256 = "1ri8hsqcd2s4dv099whgn4j1m6l9v7jyignxi9k6larg5yk7jp7b";
  };

  prePatch = ''
    mkdir node_modules
    cp -R ${nodePackages.openzeppelin-solidity}/lib/node_modules/openzeppelin-solidity node_modules
    cp -R ${nodePackages."truffle-5.0.0"}/lib/node_modules/truffle node_modules
    chmod 755 node_modules/truffle/build/
    chmod 755 node_modules/truffle/build/cli.bundled.js
    echo "truffle moved"
  '';

  patches = [ ./cache-on-tmpdir.patch ];

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ nodejs-8_x ];

  buildPhase = ''
    mkdir -p $out/bin
    cp -R . $out/

    cat > $out/bin/robonomics_migrate <<EOF
      #!${stdenv.shell}/bin/sh
      pushd $out
      exec $out/node_modules/truffle/build/cli.bundled.js migrate --contracts_build_directory /tmp/contracts/ "\$@"
    EOF
  '';

  installPhase = ''
    chmod +x $out/bin/robonomics_migrate
    wrapProgram $out/bin/robonomics_migrate \
      --set NODE_PATH "${nodeEnv}/lib/node_modules"
  '';

  meta = with stdenv.lib; {
    description = "Robonomics platform smart contracts";
    homepage = http://github.com/airalab/robonomics_contracts;
    license = licenses.bsd3;
    maintainers = with maintainers; [ akru strdn ];
  };

}
