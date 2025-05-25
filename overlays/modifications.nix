# This one contains whatever you want to overlay
# You can change versions, add patches, set compilation flags, anything really.
# https://wiki.nixos.org/wiki/Overlays
{...}: final: prev: {
  # example = prev.example.overrideAttrs (oldAttrs: rec {
  # ...
  # });
  matrix-authentication-server = prev.matrix-authentication-service.override {
    postPatch = ''
      substituteInPlace crates/config/src/sections/http.rs \
        --replace ./frontend/dist/    "$out/share/$pname/assets/"
      substituteInPlace crates/config/src/sections/templates.rs \
        --replace ./share/templates/    "$out/share/$pname/templates/" \
        --replace ./share/translations/    "$out/share/$pname/translations/" \
        --replace ./share/manifest.json "$out/share/$pname/assets/manifest.json"
      substituteInPlace crates/config/src/sections/policy.rs \
        --replace ./share/policy.wasm "$out/share/$pname/policy.wasm"
    '';
  };
}
