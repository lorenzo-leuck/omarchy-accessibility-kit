#!/usr/bin/env bash
set -eu
exec 9>"${XDG_RUNTIME_DIR:?}/omarchy-accessibility-keyboard.lock"
flock 9
if pgrep -u "$(id -u)" -x wvkbd-mobintl >/dev/null; then
  pkill -u "$(id -u)" -x wvkbd-mobintl
else
  wvkbd-mobintl --alpha 204 9>&- >/dev/null 2>&1 &
  for attempt in {1..20}; do
    pgrep -u "$(id -u)" -x wvkbd-mobintl >/dev/null && break
    sleep 0.05
  done
fi
