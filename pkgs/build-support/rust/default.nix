{ stdenv, cacert, git, rust, cargo-vendor, python3 }:
let
  fetchcargo = import ./fetchcargo.nix {
    inherit stdenv cacert git rust cargo-vendor python3;
  };
in
{ name, cargoSha256 ? "unset"
, src ? null
, srcs ? null
, cargoPatches ? []
, patches ? []
, sourceRoot ? null
, logLevel ? ""
, buildInputs ? []
, cargoUpdateHook ? ""
, cargoDepsHook ? ""
, cargoBuildFlags ? []

, cargoVendorDir ? null
, ... } @ args:

assert cargoVendorDir == null -> cargoSha256 != "unset";

let
  cargoDeps = if cargoVendorDir == null
    then fetchcargo {
        inherit name src srcs sourceRoot cargoUpdateHook;
        patches = cargoPatches;
        sha256 = cargoSha256;
      }
    else null;

  setupVendorDir = if cargoVendorDir == null
    then ''
      unpackFile "$cargoDeps"
      cargoDepsCopy=$(stripHash $(basename $cargoDeps))
      chmod -R +w "$cargoDepsCopy"
    ''
    else ''
      cargoDepsCopy="$sourceRoot/${cargoVendorDir}"
    '';

in stdenv.mkDerivation (args // {
  inherit cargoDeps;

  patchRegistryDeps = ./patch-registry-deps;

  buildInputs = [ cacert git rust.cargo rust.rustc ] ++ buildInputs;

  patches = cargoPatches ++ patches;

  configurePhase = args.configurePhase or ''
    runHook preConfigure
    # noop
    runHook postConfigure
  '';

  postUnpack = ''
    eval "$cargoDepsHook"

    ${setupVendorDir}

    mkdir .cargo
    config="$(pwd)/$cargoDepsCopy/.cargo/config";
    if [[ ! -e $config ]]; then
      config=${./fetchcargo-default-config.toml};
    fi;
    substitute $config .cargo/config \
    --subst-var-by vendor "$(pwd)/$cargoDepsCopy"

    unset cargoDepsCopy

    export RUST_LOG=${logLevel}
  '' + (args.postUnpack or "");

  buildPhase = with builtins; args.buildPhase or ''
    runHook preBuild
    echo "Running cargo build --release ${concatStringsSep " " cargoBuildFlags}"
    cargo build --release --frozen ${concatStringsSep " " cargoBuildFlags}
    runHook postBuild
  '';

  checkPhase = args.checkPhase or ''
    runHook preCheck
    echo "Running cargo test"
    cargo test
    runHook postCheck
  '';

  doCheck = args.doCheck or true;

  installPhase = args.installPhase or ''
    runHook preInstall
    mkdir -p $out/bin
    find target/release -maxdepth 1 -executable -type f -exec cp "{}" $out/bin \;
    runHook postInstall
  '';

  passthru = { inherit cargoDeps; } // (args.passthru or {});
})
