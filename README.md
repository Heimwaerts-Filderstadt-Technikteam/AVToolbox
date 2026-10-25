# AV Toolbox

Dashboard mit 11 AV-, Broadcast- und Streaming-Werkzeugen – komplett in **einer Datei** (`index.html`), ohne Abhängigkeiten, offline nutzbar. Alle Berechnungen laufen lokal im Browser.

| Werkzeug | Funktion |
|---|---|
| Kabellängen-Rechner | 121 Signaltypen (HDMI, SDI, USB/Thunderbolt, Netzwerk, Glasfaser, Audio, Steuerung, HF …) plus Lautsprecherleitungs-Rechner |
| Video-Bandbreitenrechner | Unkomprimierte Bandbreite und Auslastung von SDI/HDMI/DP/TB/Netzwerk |
| Strom- & USV-Rechner | Planungsreserve, Gleichzeitigkeit, Drehstrom-Phasenaufteilung, Spannungsfall, Generator, Wärme, Kosten, USV-Dimensionierung, Bericht |
| Kabel-Label-Generator | Flag/Wrap/Simple, Brother TZe 6–36 mm, A4/Letter, editierbare Farblegende, PNG-Export für P-touch |
| Streaming-Bitrate-Rechner | 13 Plattformen (YouTube, Twitch, Kick, Facebook, Instagram, TikTok, LinkedIn, X, Vimeo, IVS, Dacast, Restream, Contribution) |
| Streaming-XML-Generator | Blackmagic Streaming-XML (ATEM Mini Pro/Extreme, Web Presenter) |
| Testbilder & Testvideos | 10 Muster, Vollbild, PNG, WebM-Aufnahme, AV-Sync mit Ton |
| Millisekunden ↔ Frames | ms ↔ Frames, Timecode ↔ Frames |
| Produktionsuhr | Digital, Studio-Uhr (LED-Punkte, 7-Segment) und Analog; Countdown, Stoppuhr, Zeitzonen |
| Layouts (ATEM SuperSource) | Drag-&-Drop-Editor mit Export als ATEM-Makro-XML |
| Stinger-Generator | 10 Stile, eigene Formen/Logos/Texturen, Timing, Effekte, Export mit Alpha und Matte |

Die aktuelle Version steht oben rechts in der App.

## Lokal nutzen

`index.html` per Doppelklick im Browser öffnen – fertig.

## Auf einem Linux-Server betreiben (ohne Docker)

Benötigt nur Python 3. `server.py` ist ein Mini-Webserver, der ausschließlich die App ausliefert.

```bash
sudo git clone https://github.com/Heimwaerts-Filderstadt-Technikteam/AVToolbox.git /opt/av-toolbox
cd /opt/av-toolbox
sudo bash install.sh          # Systemdienst „av-toolbox“ auf Port 8080 (anderer Port: sudo bash install.sh 9000)
```

Danach läuft die App unter `http://<server>:8080` und startet nach einem Reboot automatisch.

**Updates:**

```bash
cd /opt/av-toolbox && sudo git pull
```

Die neue Version ist sofort live, ein Neustart ist nicht nötig (Browser einmal neu laden).

Alternativ vom eigenen Rechner ohne Git auf dem Server: in `deploy.sh` den `SERVER` eintragen, dann `./deploy.sh setup` (einmalig) bzw. `./deploy.sh` (Update).

**Nginx Proxy Manager:** Proxy Host auf `<Server-IP>:8080` zeigen lassen und SSL aktivieren. Läuft der NPM in Docker auf demselben Server, die LAN-IP des Servers statt `localhost` verwenden.

**Nützlich:**
- Status: `systemctl status av-toolbox`
- Logs: `journalctl -u av-toolbox -n 30`
- Entfernen: `sudo systemctl disable --now av-toolbox && sudo rm /etc/systemd/system/av-toolbox.service`

## Hinweise

Alle Richtwerte (Kabellängen, Bitraten, Strom, USV) sind Planungshilfen ohne Gewähr. Elektrische Installationen nur durch eine Elektrofachkraft. Inspiriert von den kostenlosen Tools von Here to Record / H2R Gear.
