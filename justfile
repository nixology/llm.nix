# Auto-detect system architecture
system := `nix eval --impure --raw --expr 'builtins.currentSystem'`

# Default recipe: show help
default:
    @just --list --unsorted

help:
  nix run . -- --help

login:
  llm github_copilot auth login

download:
  caffeinate llm mlx download-model unsloth/Qwen3.6-27B-MLX-8bit

all-models:
  llm models

github-models:
  llm github_copilot models

models:
  llm mlx models

manage-models:
  llm mlx manage-models

plugins:
  llm plugins

respond:
  llm -m github_copilot/claude-sonnet-4.6 "hello" -o max_tokens 100
