{
  description = "Nix flake for generating Grått chiffer 2";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "gratt-chiffer-2";
          src = ./.;
          buildInputs = with pkgs; [ gnumake clang-tools csound ];
          installPhase = ''
            mkdir -p $out
            cp track.wav $out
          '';
        };
      }
    );
}
