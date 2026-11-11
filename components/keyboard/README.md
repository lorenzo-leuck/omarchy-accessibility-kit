# Omarchy on-screen keyboard

A mouse-operated Omarchy bar button that opens and closes `wvkbd-mobintl`.
Repeated clicks toggle the keyboard rather than launching stacked copies.

## Requirements

- Omarchy with the Quickshell plugin system
- `wvkbd` (provides `wvkbd-mobintl`)
- `bash`, `pgrep`, `pkill`, and `flock`

Install the keyboard from the AUR:

```bash
omarchy pkg aur add wvkbd
```

## Installation

Place this repository at `~/.config/omarchy/plugins/lorenzo.keyboard`, then run:

```bash
omarchy-shell shell rescanPlugins
omarchy plugin enable lorenzo.keyboard
omarchy bar move lorenzo.keyboard --section right
```

Click the keyboard icon to open the keyboard. Click again to close it.
Closing also terminates any other `wvkbd-mobintl` instances owned by your user.

## Limitations

- This plugin runs inside the desktop session, not at the encrypted-disk boot prompt.
- Fullscreen menus using exclusive keyboard focus can block keyboard clicks.
  On the original installation, a separate local clone of `omarchy.menu`
  (`lorenzo.menu`) was adjusted to respect keyboard-reserved space and switch
  from a short exclusive focus prime to on-demand focus. That menu customization
  is **not included in this repository**.
- The plugin ID and launch path currently use `lorenzo.keyboard`; keep that
  directory name when installing.

## Files

- `manifest.json`: plugin metadata
- `BarWidget.qml`: bar button
- `toggle.sh`: serialized keyboard toggle

No license has been selected yet. Choose one before publishing for reuse.
