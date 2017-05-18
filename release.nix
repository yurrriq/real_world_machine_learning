{ pkgs, buildPythonPackage, pythonPackages }:

buildPythonPackage rec {
  name = "real_world_machine_learning-${version}";
  version = builtins.readFile ./VERSION;

  src = ./.;

  propagatedBuildInputs = with pythonPackages; [ numpy ];

  meta = with pkgs.stdenv.lib; {
    description  = "Real-World Machine Learning";

    # TODO
    homepage     = "http://yurrriq.github.io/real_world_machine_learning";
    downloadPage = "https://github.com/yurrriq/real_world_machine_learning/releases";

    license      = licenses.mit;
    maintainers  = with maintainers; [ yurrriq ];
    platforms    = platforms.unix;
  };
}
