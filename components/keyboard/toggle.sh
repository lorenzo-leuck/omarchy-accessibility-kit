#!/usr/bin/env bash
set -eu

# Serialize clicks so two launches cannot race each other.
exec 9>"${XDG_RUNTIME_DIR:?}/lorenzo-keyboard.lock"
flock 9

if pgrep -u "$(id -u)" -x wvkbd-mobintl >/dev/null; then
  pkill -u "$(id -u)" -x wvkbd-mobintl
else
  # Match the desktop's 80% opacity (204 out of 255).
  wvkbd-mobintl --alpha 204 9>&- >/dev/null 2>&1 &
  # Keep the lock until the new process can be found by the next click.
  for attempt in {1..20}; do
    if pgrep -u "$(id -u)" -x wvkbd-mobintl >/dev/null; then
      break
    fi
    sleep 0.05
  done
fi
