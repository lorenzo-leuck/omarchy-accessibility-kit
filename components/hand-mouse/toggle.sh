#!/usr/bin/env bash
set -eu
exec 9>"${XDG_RUNTIME_DIR:?}/lorenzo-hand-mouse.lock"
flock 9
if systemctl --user is-active --quiet mudra.service; then
  systemctl --user stop mudra.service
else
  if ! systemctl --user start mudra.service; then
    notify-send "Hand-tracking mouse" "Could not start Mudra. Check journalctl --user -u mudra.service."
    exit 1
  fi
fi
