{
  #     ____             __
  #    / __ \____ ______/ /______ _____ ____  _____
  #   / /_/ / __ `/ ___/ //_/ __ `/ __ `/ _ \/ ___/
  #  / ____/ /_/ / /__/ ,< / /_/ / /_/ /  __(__  )
  # /_/    \__,_/\___/_/|_|\__,_/\__, /\___/____/
  #                             /____/
  description = "Sokhibjon's helpful packages";

  # inputs are other flakes you use within your own flake, dependencies
  # for your flake, etc.
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Flake utils for eachSystem
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  } @ inputs: let
    # Self instance pointer
    outputs = self;
  in
    # Attributes for each system
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        # Nixpkgs packages for the current system
        {
          # Your custom packages
          # Acessible through 'nix build', 'nix shell', etc
          packages = import ./packages {inherit pkgs;};

          # Formatter for your nix files, available through 'nix fmt'
          # Other options beside 'alejandra' include 'nixpkgs-fmt'
          formatter = pkgs.alejandra;

          # Development shells
          devShells.default = import ./shell.nix {inherit pkgs;};
        }
    )
    # and ...
    //
    # Attribute from static evaluation
    {
      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays {inherit inputs;};
    };
}
