# Omarchy Accessibility Kit

A small Omarchy 4+ accessibility bundle assembled from local customizations: a bar-toggle for the `wvkbd` on-screen keyboard and an optional F8 push-to-talk voice launcher. It is designed for systems where the built-in keyboard is unavailable or difficult to use.

This repository does not redistribute third-party wallpaper or webcam/mouse projects. See “Related projects” for their upstream install instructions.

## Components

- `keyboard/`: Quickshell bar widget that toggles `wvkbd-mobintl` (repeat clicks are serialized).
- `voice/`: allowlisted launcher using Voxtype transcription and a hold-F8/release-F8 Hyprland binding. Spoken input is never passed to a shell; supported phrases are listed below.
- `install.sh`: installs the keyboard plugin and, if requested, voice command helper and binding snippets. Review it before running.

## Install

Requirements: Omarchy 4+ with `omarchy-shell`, Hyprland Lua config, Bash, `flock`; `wvkbd` is required for keyboard support. Install it with `omarchy pkg aur add wvkbd`.

```sh
git clone https://github.com/lorenzo-leuck/omarchy-accessibility-kit.git
cd omarchy-accessibility-kit
./install.sh keyboard
# Optional voice commands (requires Voxtype and its configured service):
./install.sh voice
```

The installer copies the keyboard plugin to `~/.config/omarchy/plugins/omarchy-accessibility.keyboard`, rescans plugins and enables it. The voice option installs `omarchy-voice-open` to `~/.local/bin` and prints the F8 binding snippet; it does not rewrite your Hyprland config. Add the printed bindings to `~/.config/hypr/bindings.lua`, then validate with `hyprctl reload` and `hyprctl configerrors`.

## Keyboard

Click the ⌨ bar button to show/hide the on-screen keyboard. It closes existing `wvkbd-mobintl` instances owned by your user. It is a desktop-session aid, not an encrypted-disk boot keyboard.

## Voice commands

Hold F8 while speaking, release to execute. Recognized phrases: “open agent/browser/files/terminal/editor”, optionally “in workspace one” through “ten”; “close workspace one” through “ten”; or “close all”. Closing windows sends normal Hyprland close requests and does not force-kill apps. Unrecognized phrases do nothing. F9 is untouched.

Dependencies: `voxtype`, `notify-send`, and Omarchy's launcher commands. Voice recordings/transcripts use a private runtime directory and are removed after processing. Test phrase parsing without launching anything with `omarchy-voice-open run 'open editor' --dry-run`.

## Related projects (not bundled)

- Animated video wallpaper: [Motion Wallpaper for Omarchy](https://github.com/28allday/Motion-Wallpaper-Omarchy) (upstream installer supports video clips; not GIF-specific).
- Webcam gesture mouse: [mudra](https://github.com/atayoez/mudra) (separate AGPL-3.0 project; follow its own installation and license terms).

## License

The keyboard plugin and voice helper in this repository are licensed under the MIT License. Third-party projects retain their own licenses and are not included here.
