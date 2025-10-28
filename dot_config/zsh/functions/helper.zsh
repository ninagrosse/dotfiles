# make a directory and cd inside
mkcd() {
  \mkdir -p "$1"
  cd "$1"
}

# change to a temporary directory
tempe() {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}
