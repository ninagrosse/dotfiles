# Zellij function to either attach/resurrect a session or create a new one, if none exists
function za() {
  local session_name="$1"
  local ZJ_SESSIONS=$(zellij list-sessions -n -s)
  local NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -w)

  # If a session name is provided, check if it exists
  if [ -n "$session_name" ]; then
    if echo "$ZJ_SESSIONS" | grep -q "^$session_name$"; then
      zellij attach "$session_name"
      return
    else
      # Session doesn't exist, handle based on number of existing sessions
      if [ "${NO_SESSIONS}" -eq 0 ]; then
        # 'No active zellij sessions found' message from zellij itself
        echo -n "Do you want to create a new one with name '$session_name'? (y/N): "
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
          zellij --session "$session_name"
        fi
        return
      elif [ "${NO_SESSIONS}" -eq 1 ]; then
        echo -n "Session '$session_name' not found. Do you want to attach to session '$ZJ_SESSIONS'? (y/N): "
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
          zellij attach "$ZJ_SESSIONS"
        fi
        return
      else
        # Multiple sessions exist, show fzf selection
        echo "Session '$session_name' not found. Select from available sessions:"
        zellij attach "$(echo "${ZJ_SESSIONS}" | fzf --height=20% --reverse)"
        return
      fi
    fi
  fi

  # When no session name is provided
  # - No attachable session: create new session
  # - One session (alive or exited): attach / resurrect session
  # - Two or more sessions (alive or exited): select session with fzf
  if [ "${NO_SESSIONS}" -eq 1 ]; then
    zellij attach "$ZJ_SESSIONS"
  elif [ "${NO_SESSIONS}" -ge 2 ]; then
    zellij attach "$(echo "${ZJ_SESSIONS}" | fzf --height=20% --reverse)"
  else
    zellij
  fi
}
