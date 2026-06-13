{
  description = "Access large language models from the command-line";

  inputs.flake.url = "github:nixology/flake.nix";

  inputs.llm-mlx.url = "github:simonw/llm-mlx/0.4";
  inputs.llm-mlx.flake = false;

  inputs.mlx.url = "github:nixology/mlx.nix";
  inputs.mlx.inputs.flake.follows = "flake";

  outputs =
    inputs: with inputs.flake.lib; mkFlake { inherit inputs; } { imports = modulesIn ./modules; };
}
