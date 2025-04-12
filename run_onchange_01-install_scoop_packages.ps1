# Install scoop buckets and packages

$buckets = @(
  "extras"
)

$packages = @(
  "age",
  "bat",
  "chafa",
  "curl",
  "curlie",
  "delta",
  "duf",
  "exiftool",
  "eza",
  "fastfetch",
  "fd",
  "fzf",
  "git-aliases",
  "jq",
  "lazygit",
  "less",
  "make",
  "mingw",
  "nano",
  "neovide",
  "neovim",
  "nvm",
  "ripgrep",
  "starship",
  "tealdeer",
  "ugrep",
  "win32yank",
  "yazi",
  "zoxide"
)

foreach ($bucket in $buckets) {
  scoop bucket add $bucket
}

foreach ($package in $packages) {
  scoop install $package
}

# Build bat cache so it can pick up Catppuccin theme
bat cache --build

# Run 'ya pack' to install yazi plugins and themes
ya pack -i

# Set YAZI_FILE_ONE system env, so yazi file previews work
[System.Environment]::SetEnvironmentVariable('YAZI_FILE_ONE','C:\Program Files\Git\usr\bin\file.exe', 'User')
