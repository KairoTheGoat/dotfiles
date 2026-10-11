#!/usr/bin/env bash
# Copy live configs into this repo, commit and push.
set -e
cd "$(dirname "$0")"
cp ~/.config/waybar/custom/{config.jsonc,style.css} waybar/
cp ~/.config/hypr/hyprlock.conf hyprlock/
cp /usr/share/sddm/themes/terminal/{Main.qml,metadata.desktop} sddm-terminal/
git add -A
git commit -m "Sync configs $(date +%F)" || echo "nothing to commit"
git push
