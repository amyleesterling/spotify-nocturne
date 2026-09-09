#!/bin/bash
set -euo pipefail
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.spicetify:$PATH"
quiet_palette="${1:-Nocturne}"
case "$quiet_palette" in Nocturne|Linen) ;; *) echo 'Choose Nocturne or Linen.'; exit 1;; esac
if ! command -v spicetify >/dev/null 2>&1; then
  echo 'Install Spicetify first: https://spicetify.app/docs/getting-started'
  exit 1
fi
quiet_source="$(cd -- "$(dirname -- "$0")" && pwd)"
quiet_config="$(spicetify -c)"
if [ ! -f "$quiet_config" ]; then echo 'Complete Spicetify setup first.'; exit 1; fi
quiet_root="$(dirname -- "$quiet_config")"
quiet_destination="$quiet_root/Themes/Quiet"
quiet_backup="$(mktemp -d "$quiet_root/quiet-backup-XXXXXXXX")"
cp "$quiet_config" "$quiet_backup/config-xpui.ini"
if [ -d "$quiet_destination" ]; then cp -R "$quiet_destination" "$quiet_backup/Quiet"; fi
mkdir -p "$quiet_destination"
cp "$quiet_source/Quiet/user.css" "$quiet_source/Quiet/color.ini" "$quiet_destination/"
echo "Previous configuration saved in $quiet_backup"
spicetify config current_theme Quiet color_scheme "$quiet_palette" inject_css 1 replace_colors 1
spicetify apply
echo "Quiet / $quiet_palette applied."
