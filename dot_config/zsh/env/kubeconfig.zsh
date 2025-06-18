local default_config="$HOME/.kube/config"
local context_dir="$HOME/.kube/contexts"
local context_configs=()

# Only include default config if it exists
[[ -f $default_config ]] && context_configs+=("$default_config")

# Add all YAML/YML files from ~/.kube/contexts (if they exist)
if [[ -d $context_dir ]]; then
  for file in "$context_dir"/*.yaml(N) "$context_dir"/*.yml(N); do
    [[ -f $file ]] && context_configs+=("$file")
  done
fi

# Export KUBECONFIG as colon-separated list
if (( ${#context_configs[@]} )); then
  export KUBECONFIG="${(j.:.)context_configs}"
else
  unset KUBECONFIG
fi
