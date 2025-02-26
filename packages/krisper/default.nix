{
  lib,
  xdg-utils,
  findutils,
  callPackage,
  writeShellApplication,
}: let
  krisp-patcher = callPackage ../krisp-patcher {};
in
  (writeShellApplication {
    name = "krisper";
    runtimeInputs = [xdg-utils krisp-patcher findutils];
    text = builtins.readFile ./krisper.sh;
  })
  // {
    meta = with lib; {
      licenses = licenses.mit;
      platforms = platforms.all;
    };
  }
