{ nixpkgs ? import <nixpkgs> {} }:

let

  inherit (nixpkgs) pkgs;

  pkg = pkgs.callPackage ./release.nix {
    inherit pkgs;
    inherit (pkgs.python35Packages) buildPythonPackage;
  };

  env = (pkgs.python35.buildEnv.override {
    extraLibs = [ pkg ];
  }).env;

in

if pkgs.lib.inNixShell
   then env
   else pkg
