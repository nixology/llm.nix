{ inputs, ... }:
let
  _llm-mlx_ = inputs.flake.lib.metadataForFlakeInput inputs.self inputs.llm-mlx;
in
{
  perSystem =
    { inputs', pkgs, ... }:
    {
      packages.${_llm-mlx_.pname} =
        with pkgs.python3.pkgs;
        buildPythonPackage {
          inherit (_llm-mlx_) pname src version;
          pyproject = true;

          patches = [
            (pkgs.fetchurl {
              url = "https://github.com/simonw/llm-mlx/pull/20.patch";
              hash = "sha256-J3+Y55MQpNaIuFOvcZL9huWQ/n8W2zEmo/9IkMClAUU=";
            })
          ];

          pythonImportsCheck = [ "llm_mlx" ];

          build-system = [
            setuptools
            setuptools-scm
          ];

          dependencies = [
            llm
            inputs'.mlx.packages.mlx-lm
          ];
        };
    };
}
