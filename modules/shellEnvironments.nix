{
  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      python = pkgs.python3;

      default = {
        mkShellOverrides = {
          stdenv = pkgs.stdenvNoCC;
        };
        shellHook =
          let
            venvDir = "./.venv";
          in
          ''
            if [ -d ${venvDir} ]; then
              echo "Skipping venv creation, ${venvDir} already exists."
            else
              echo "Creating new venv environment in path: '${venvDir}'"
              ${python.pkgs.python.interpreter} -m venv "${venvDir}"
            fi

            source "${venvDir}/bin/activate"
          '';
        packages = [
          config.packages.llm
          (python.withPackages (
            ps: with ps; [
              huggingface-hub
              jupyterlab
              notebook
              pip
              setuptools
            ]
          ))
        ];
      };
    in
    {
      shellEnvironments.default =
        with config.shellEnvironments;
        lib.mkMerge [
          default
          nix
        ];
    };
}
