{ mkDerivation, aeson, async, base, base58-bytestring, bytestring
, concurrent-machines, containers, cryptonite, data-default
, exceptions, generics-sop, hashable, hpack, machines, memory
, microlens, monad-control, monad-logger, mtl, optparse-applicative
, process, secp256k1-haskell, stdenv, text, web3, fetchFromGitHub
}:

mkDerivation rec {
  pname = "robonomics-tools";
  version = "0.2.0.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    rev = "v${version}";
    sha256 = "05jqf6nr6l0nqi5pnzk2d341j9f9y3zk863zh4mnfdh9yfxmhszz";
  };

  isLibrary = true;
  isExecutable = true;

  libraryHaskellDepends = [
    aeson async base base58-bytestring bytestring concurrent-machines
    containers cryptonite data-default exceptions generics-sop hashable
    machines memory microlens monad-control monad-logger mtl
    optparse-applicative process secp256k1-haskell text web3
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson async base base58-bytestring bytestring concurrent-machines
    containers cryptonite data-default exceptions generics-sop hashable
    machines memory microlens monad-control monad-logger mtl
    optparse-applicative process secp256k1-haskell text web3
  ];
  testHaskellDepends = [
    aeson async base base58-bytestring bytestring concurrent-machines
    containers cryptonite data-default exceptions generics-sop hashable
    machines memory microlens monad-control monad-logger mtl
    optparse-applicative process secp256k1-haskell text web3
  ];
  preConfigure = "hpack";

  homepage = "https://github.com/airalab/robonomics-tools#readme";
  description = "Robonomics.network tools";
  license = stdenv.lib.licenses.bsd3;
  maintainers = with stdenv.lib.maintainers; [ akru ];
}
