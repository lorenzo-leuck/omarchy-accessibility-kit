# Omarchy Accessibility and Desktop Toolkit

A source archive of the Omarchy/Linux utilities and customizations collected for this laptop, organized so they can be reviewed and reinstalled on another Omarchy system. The top-level plugin is the on-screen keyboard; the `components/` directory also contains the other complete utilities, not merely links.

## Included

- `components/keyboard/` — complete Quickshell bar widget/plugin for toggling `wvkbd-mobintl`.
- `components/voice/omarchy-voice-open` — local allowlisted Voxtype voice launcher (open apps/workspaces and request window closes without shell interpretation).
- `config/bindings.lua` — snapshot of the Hyprland personal bindings including F8 voice push-to-talk and other overrides. Paths in the original snapshot refer to Lorenzo's account; adapt them before use elsewhere. `config/bindings.lua.before-voice-open` is the saved pre-voice snapshot.
- `components/motion-wallpaper/` — complete local Motion Wallpaper Omarchy checkout: QML service/widget/panel, CLI, installer, docs and assets.
- `components/mudra/` — complete webcam hand-gesture mouse project including setup/run scripts and ONNX models.
- `components/hand-mouse/` — Omarchy bar toggle for the `mudra.service` systemd user unit.
- `components/menu/` — complete local Quickshell menu clone (`lorenzo.menu`) and its bar widget.

## On-screen keyboard plugin (Omarchy 4+)

Install `wvkbd`, then this plugin:

```sh
omarchy pkg aur add wvkbd
mkdir -p ~/.config/omarchy/plugins/lorenzo.keyboard
cp -a components/keyboard/. ~/.config/omarchy/plugins/lorenzo.keyboard/
omarchy-shell shell rescanPlugins
omarchy plugin enable lorenzo.keyboard
omarchy bar move lorenzo.keyboard --section right
```

Click its bar button to toggle the on-screen keyboard. It is not available at the encrypted-disk boot prompt.

## Voice push-to-talk

Requires Voxtype configured and running, plus Omarchy launchers and `notify-send`:

```sh
install -Dm755 components/voice/omarchy-voice-open ~/.local/bin/omarchy-voice-open
```

Add these bindings to `~/.config/hypr/bindings.lua`, adapting/removing existing F8 bindings first:

```lua
o.bind("F8", "Start voice command (push-to-talk)", "omarchy-voice-open start")
o.bind("F8", "Run voice command (release)", "omarchy-voice-open stop", { release = true })
```

Then run `hyprctl reload` and `hyprctl configerrors`. F9 is not touched. The recognized phrases are documented in the helper's README section below (open agent/browser/files/terminal/editor, optionally in workspace 1–10; close workspace 1–10; close all). Safe parser check: `~/.local/bin/omarchy-voice-open run 'open editor' --dry-run`.

## Motion Wallpaper

The complete local checkout is in `components/motion-wallpaper/`. It is the upstream MIT-licensed Omarchy plugin and includes its own `README.md`, `LICENSE`, `wallpaper.sh`, QML sources and assets. Read that component README for its Omarchy 4+ requirements and installer. The current upstream plugin plays looping video clips; this is not a GIF implementation.

## Mudra webcam gesture mouse

The full local project is in `components/mudra/`, including the laptop's current `mudra.py` changes and the model files. Its README and AGPL-3.0 `LICENSE` contain its requirements and setup steps. The companion bar control is in `components/hand-mouse/`; it expects a user service named `mudra.service`, so create/configure that service separately using the paths documented in Mudra before enabling the widget.

## Custom Omarchy menu

`components/menu/` contains the complete local menu clone and `manifest.json`. It is a custom copy of Omarchy's menu implementation; check Omarchy's upstream license and compatibility before redistributing or using it on another version. Install as `~/.config/omarchy/plugins/lorenzo.menu/`, rescan plugins, and enable `lorenzo.menu`. This clone was previously adjusted for the on-screen keyboard's reserved space/focus behavior.

## F8 and other bindings snapshot

`config/bindings.lua` is a full snapshot, not a drop-in portable config: it includes personal defaults, F8 and Agent/split overrides, and an absolute path under `/home/lorenzo`. Prefer copying only the relevant binding lines into the target account's existing config. Never overwrite the target machine's full config without reviewing it.

## Licensing and attribution

The keyboard and voice helper are licensed under the repository's MIT License. Bundled components retain their own notices: Motion Wallpaper has its own MIT license; Mudra is AGPL-3.0; the menu is an Omarchy-derived clone whose upstream license terms must be respected. The root MIT license does not replace or relicense those component licenses. Wallpaper/media assets retain their respective upstream notices. Review each component's license before redistributing it.
