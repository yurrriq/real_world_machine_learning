{ nixpkgs ? import <nixpkgs> {} }:

let

  inherit (nixpkgs) pkgs;

  pkg = pkgs.callPackage ./src/python {
    inherit pkgs;
    inherit (pkgs.python35Packages) buildPythonPackage;
    pythonPackages = pkgs.python35Packages;
  };

  env = (pkgs.python35.buildEnv.override {
    extraLibs = [ pkg ];
  }).env;

in

if pkgs.lib.inNixShell
   then env
   else pkg
