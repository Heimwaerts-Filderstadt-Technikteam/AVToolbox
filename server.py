#!/usr/bin/env python3
"""AV Toolbox – minimaler Webserver ohne Abhängigkeiten (nur Python 3)."""
import os, sys
from http.server import ThreadingHTTPServer, SimpleHTTPRequestHandler

PORT = int(os.environ.get("AVTB_PORT", sys.argv[1] if len(sys.argv) > 1 else 8080))
BIND = os.environ.get("AVTB_BIND", "0.0.0.0")
ROOT = os.path.dirname(os.path.abspath(__file__))

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *a, **kw):
        super().__init__(*a, directory=ROOT, **kw)
    def do_GET(self):
        # Nur die App ausliefern – keine Skripte oder Verzeichnislisten
        if self.path.split("?")[0] not in ("/", "/index.html"):
            self.path = "/index.html"
        return super().do_GET()
    do_HEAD = do_GET
    def end_headers(self):
        self.send_header("Cache-Control", "no-cache")
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Referrer-Policy", "no-referrer")
        super().end_headers()
    def log_message(self, fmt, *args):
        pass

if __name__ == "__main__":
    print(f"AV Toolbox läuft auf http://{BIND}:{PORT}", flush=True)
    ThreadingHTTPServer((BIND, PORT), Handler).serve_forever()
