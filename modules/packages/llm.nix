{
  perSystem =
    { config, pkgs, ... }:
    {
      packages = {
        default = config.packages.llm;

        llm =
          (pkgs.python3.withPackages (
            ps: with ps; [
              llm
              llm-github-copilot
              config.packages.llm-mlx
            ]
          )).overrideAttrs
            (old: {
              meta = old.meta // {
                mainProgram = "llm";
              };
            });
      };
    };
}
