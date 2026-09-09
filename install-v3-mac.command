#!/bin/bash
set -euo pipefail
quiet_palette="${1:-Nocturne}"
case "$quiet_palette" in Nocturne|Linen) ;; *) echo 'Choose Nocturne or Linen.'; exit 1;; esac
quiet_source="$(cd -- "$(dirname -- "$0")" && pwd)"
quiet_root="$HOME/.config/spicetify"
quiet_bin="$quiet_root/bin"
quiet_exe="$quiet_bin/spicetify"
if [ "$(uname -s)" != Darwin ]; then echo 'This installer is for macOS.'; exit 1; fi
quiet_app=/Applications/Spotify.app
if [ ! -f "$quiet_app/Contents/MacOS/Spotify" ]; then quiet_app="$HOME/Applications/Spotify.app"; fi
if [ ! -f "$quiet_app/Contents/MacOS/Spotify" ]; then echo 'Install Spotify from spotify.com and open it first.'; exit 1; fi
if [ ! -w "$quiet_app/Contents/Resources/Apps" ]; then echo 'Spotify is not writable by your account. Install it in your personal Applications folder before continuing.'; exit 1; fi
mkdir -p "$quiet_bin"
if [ ! -x "$quiet_exe" ]; then
  case "$(uname -m)" in
    arm64) quiet_arch=aarch64; quiet_sha=757233f9c28ae587cea3db179514d0dcd6beac5be40fc48933c148b51884beb2 ;;
    x86_64) quiet_arch=x86_64; quiet_sha=aa0776752f91296cb6ee63230d8175af40ff948731afd01cce4ec275348c11cf ;;
    *) echo 'Unsupported Mac architecture.'; exit 1 ;;
  esac
  quiet_download="$(mktemp -d "${TMPDIR:-/tmp}/quiet-runtime.XXXXXXXX")"
  curl --fail --location --proto '=https' "https://github.com/spicetify/cli/releases/download/v3.0.0-beta.14/spicetify-3.0.0-beta.14-macos-$quiet_arch.tar.zst" -o "$quiet_download/runtime.tar.zst"
  printf '%s  %s\n' "$quiet_sha" "$quiet_download/runtime.tar.zst" | shasum -a 256 -c -
  if ! tar -xf "$quiet_download/runtime.tar.zst" -C "$quiet_bin"; then
    echo 'Your tar cannot extract zstd archives. Install zstd (for example: brew install zstd), then retry.'; exit 1
  fi
fi
if [ "$("$quiet_exe" --version)" != 'spicetify 3.0.0-beta.14' ]; then echo 'Requires Spicetify 3.0.0-beta.14 in ~/.config/spicetify/bin.'; exit 1; fi
quiet_backup="$(mktemp -d "$quiet_root/quiet-backup-XXXXXXXX")"
quiet_config="$quiet_root/config.toml"
if [ -f "$quiet_config" ]; then cp "$quiet_config" "$quiet_backup/config.toml"; fi
quiet_destination="$quiet_root/modules/quiet"
if [ -d "$quiet_destination" ]; then cp -R "$quiet_destination" "$quiet_backup/quiet"; fi
# TOML basic strings need escaped backslashes and quotes in user paths.
quiet_toml() { printf '%s' "$1" | sed 's/\\/\\\\/g;s/"/\\"/g'; }
if [ -f "$quiet_config" ]; then
  sed -E '/^(mirror|daemon|spotify_data_dir|spotify_exec|offline_bnk_dir)[[:space:]]*=/d' "$quiet_config" > "$quiet_backup/config-rest.txt"
else : > "$quiet_backup/config-rest.txt"; fi
cat "$quiet_backup/config-rest.txt" > "$quiet_config"
printf '\nmirror = false\ndaemon = false\nspotify_data_dir = "%s"\nspotify_exec = "%s"\noffline_bnk_dir = "%s"\n' "$(quiet_toml "$quiet_app/Contents/Resources")" "$(quiet_toml "$quiet_app/Contents/MacOS/Spotify")" "$(quiet_toml "$HOME/Library/Application Support/Spotify/PersistentCache")" >> "$quiet_config"
mkdir -p "$quiet_destination"
cp "$quiet_source/Quiet-v3/metadata.json" "$quiet_source/Quiet-v3/user.css" "$quiet_source/Quiet-v3/color.ini" "$quiet_source/Quiet-v3/icons.js" "$quiet_destination/"
awk -v wanted="[$quiet_palette]" '/^\[/{section=$0} section==wanted {print}' "$quiet_destination/color.ini" > "$quiet_backup/palette.ini"
cp "$quiet_backup/palette.ini" "$quiet_destination/color.ini"
export RUST_LOG=info
echo "Backup: $quiet_backup"
"$quiet_exe" apply
echo "Quiet / $quiet_palette installed. Open Spotify normally."
