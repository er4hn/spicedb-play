{
  description = "Nix flake for installing SpiceDB and Zed from nixpkgs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages = {
          spicedb = pkgs.spicedb;
          zed = pkgs.spicedb-zed;  # Referencing Zed from the SpiceDB package
          default = pkgs.symlinkJoin {
            name = "authzed-tools";
            paths = [ pkgs.spicedb pkgs.spicedb-zed ];
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.spicedb pkgs.spicedb-zed ];
          shellHook = ''
            echo "SpiceDB and Zed are now available"
            spicedb version
            zed version
          '';
        };
      }
    );
}
