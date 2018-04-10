{ config, pkgs, ... }:

{

  imports = [
    ../profiles/aira.nix
  ];

  services = {
    aira-quick-start.enable = true;
    parity.chain = "kovan";
  };

  # Allow the user to log in as root without a password.
  users.extraUsers.root.initialHashedPassword = "";

}
