All `plugins.*.zsh` files in this directory contain oh-my-zsh plugins which should be loaded in `.zshrc` (one plugin per line). 

`plugins.common.zsh` contains plugins which should work on every machine where oh-my-zsh can be installed. It is the only file tracked by git.

Put machine specific plugins in a separate `plugins.local.zsh`. This applies to plugins which require additional tools to be installed on the machine, e.g. docker, brew, podman etc.
