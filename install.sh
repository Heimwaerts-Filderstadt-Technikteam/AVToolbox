#!/usr/bin/env bash
# Auf dem Server ausführen:  sudo bash install.sh [PORT]
# Richtet die AV Toolbox als Systemdienst ein (startet automatisch nach Reboot).
set -euo pipefail
PORT="${1:-8080}"
DIR="$(cd "$(dirname "$0")" && pwd)"
OWNER="${SUDO_USER:-root}"
command -v python3 >/dev/null || { echo "python3 fehlt: sudo apt install python3"; exit 1; }
chown -R "$OWNER" "$DIR"
cat > /etc/systemd/system/av-toolbox.service <<UNIT
[Unit]
Description=AV Toolbox
After=network.target

[Service]
ExecStart=/usr/bin/env python3 $DIR/server.py $PORT
Restart=always
DynamicUser=yes
ProtectSystem=strict
ProtectHome=read-only
NoNewPrivileges=yes

[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable --now av-toolbox
systemctl restart av-toolbox
sleep 1
systemctl is-active --quiet av-toolbox && echo "✓ AV Toolbox läuft auf Port $PORT" || { echo "✗ Start fehlgeschlagen:"; journalctl -u av-toolbox -n 20 --no-pager; exit 1; }
