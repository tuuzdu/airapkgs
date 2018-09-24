import ./make-test.nix ({ pkgs, ... } : {
  name = "parity";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ strdn akru ];
  };

  nodes = {
    parity_service =
      { ... }:
      {
        services.parity = {
          enable = true;
          extraConfig = ''
            # API Options:
            [rpc]
            apis = ["personal"]
          '';

        };
      };
  };

  testScript = ''
    startAll;
    $parity_service->waitForUnit("parity");
    $parity_service->waitForOpenPort("8545");

    $parity_service->mustSucceed("
      curl --data '{\"method\":\"personal_newAccount\",\"params\":[\"hunter2\"],\"id\":1,\"jsonrpc\":\"2.0\"}' -H \"Content-Type: application/json\" -X POST localhost:8545
    ");

    $parity_service->mustSucceed("
      ls /var/lib/parity/.local/share/io.parity.ethereum/keys/ethereum/UTC--*
    ");

  '';
})
