"""KaliteX — yerel HTTPS sunucu (telefonda mikrofon için gerekli)."""
import http.server
import os
import ssl
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PORT = 8765
CERT = ROOT / "kalitex-local.pem"
KEY = ROOT / "kalitex-local-key.pem"


def ensure_cert():
    if CERT.exists() and KEY.exists():
        return
    print("[KaliteX] SSL sertifikasi olusturuluyor...")
    cmd = [
        "openssl", "req", "-x509", "-newkey", "rsa:2048",
        "-keyout", str(KEY), "-out", str(CERT),
        "-days", "3650", "-nodes",
        "-subj", "/CN=KaliteX-Local/O=KaliteX",
    ]
    try:
        subprocess.run(cmd, check=True, capture_output=True)
    except (FileNotFoundError, subprocess.CalledProcessError) as e:
        print("[KaliteX] HATA: openssl bulunamadi veya sertifika olusturulamadi.")
        print("        Git for Windows veya OpenSSL yukleyin, veya HTTP modunu kullanin.")
        raise SystemExit(1) from e
    print("[KaliteX] Sertifika hazir:", CERT.name)


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(ROOT), **kwargs)

    def log_message(self, fmt, *args):
        if args and "200" in str(args[1]):
            return
        super().log_message(fmt, *args)


def main():
    os.chdir(ROOT)
    ensure_cert()
    server = http.server.HTTPServer(("0.0.0.0", PORT), Handler)
    ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ctx.load_cert_chain(str(CERT), str(KEY))
    server.socket = ctx.wrap_socket(server.socket, server_side=True)
    print(f"[KaliteX] HTTPS sunucu: https://0.0.0.0:{PORT}/kalite.html")
    print("[KaliteX] Telefonda ilk acilista guvenlik uyarisi normal — Devam et deyin.")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n[KaliteX] Durduruldu.")


if __name__ == "__main__":
    main()
