#!/usr/bin/env bash
# Vom Mac aus:
#   ./deploy.sh setup     → erstes Einrichten (Dateien kopieren + Dienst installieren)
#   ./deploy.sh           → Update: nur index.html hochladen (sofort live)
#   ./deploy.sh ~/Downloads/index.html   → bestimmte Datei hochladen
SERVER="user@dein-server"      # ← einmal anpassen
REMOTE_DIR="/opt/av-toolbox"
PORT=8080

set -euo pipefail
cd "$(dirname "$0")"
if [[ "${1:-}" == "setup" ]]; then
  ssh -t "$SERVER" "sudo mkdir -p $REMOTE_DIR && sudo chown \$(id -un) $REMOTE_DIR"
  scp -q index.html server.py install.sh "$SERVER:$REMOTE_DIR/"
  ssh -t "$SERVER" "sudo bash $REMOTE_DIR/install.sh $PORT"
  exit 0
fi
FILE="${1:-index.html}"
scp -q "$FILE" "$SERVER:$REMOTE_DIR/index.html"
VER=$(grep -o 'name="version" content="[^"]*"' "$FILE" | sed 's/.*content="//;s/"//')
echo "✓ v${VER:-?} ist live – Browser einmal neu laden."
