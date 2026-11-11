#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ID="omarchy-accessibility.keyboard"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy/plugins/$PLUGIN_ID"

usage() { printf 'Usage: %s keyboard|voice\n' "$0"; }
case "${1:-}" in
  keyboard)
    command -v omarchy-shell >/dev/null || { echo 'Requires Omarchy 4+ (omarchy-shell).' >&2; exit 1; }
    command -v wvkbd-mobintl >/dev/null || { echo 'Install wvkbd first: omarchy pkg aur add wvkbd' >&2; exit 1; }
    mkdir -p "$DEST/keyboard"
    install -m 644 "$ROOT/manifest.json" "$DEST/manifest.json"
    install -m 644 "$ROOT/keyboard/BarWidget.qml" "$DEST/keyboard/BarWidget.qml"
    install -m 755 "$ROOT/keyboard/toggle.sh" "$DEST/keyboard/toggle.sh"
    omarchy-shell shell rescanPlugins
    omarchy plugin enable "$PLUGIN_ID"
    printf 'Installed keyboard plugin at %s\n' "$DEST"
    ;;
  voice)
    command -v voxtype >/dev/null || { echo 'Voice commands require Voxtype.' >&2; exit 1; }
    install -D -m 755 "$ROOT/voice/omarchy-voice-open" "$HOME/.local/bin/omarchy-voice-open"
    printf 'Installed %s\n\nAdd these lines to ~/.config/hypr/bindings.lua:\n' "$HOME/.local/bin/omarchy-voice-open"
    printf '%s\n' 'o.bind("F8", "Start voice command (push-to-talk)", "omarchy-voice-open start")' 'o.bind("F8", "Run voice command (release)", "omarchy-voice-open stop", { release = true })'
    printf '\nThen validate: hyprctl reload && hyprctl configerrors\n'
    ;;
  *) usage >&2; exit 2 ;;
esac
