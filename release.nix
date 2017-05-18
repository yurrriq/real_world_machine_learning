{ pkgs, buildPythonPackage }:

buildPythonPackage rec {
  name = "real_world_machine_learning-${version}";
  version = builtins.readFile ./VERSION;

  src = ./.;

  # propagatedBuildInputs = [ ];

  # TODO meta = { };
}
