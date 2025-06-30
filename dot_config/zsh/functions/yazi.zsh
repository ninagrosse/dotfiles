# Function for yazi to start it with just a 'y' and cd into the directory, you're currently in, when exiting yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
  echo -e -n "\x1b[4 q" # reset cursor to steady underline
}
