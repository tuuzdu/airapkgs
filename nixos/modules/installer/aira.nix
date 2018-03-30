{ config, lib, pkgs, ... }:

with lib;

{

  services = {
    aira-quick-start.enable = true;
  };

  # Allow the user to log in as root without a password.
  users.extraUsers.root.initialHashedPassword = "";

}
