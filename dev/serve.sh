#!/usr/bin/env bash
# Usnea Scroll dev server — serve index.html over the LAN for phone testing.
# Usage:  ./dev/serve.sh {start|stop|status|restart}
# Open the PC firewall once so the phone can reach it:  sudo ufw allow 8000/tcp
# Then on the phone (same wifi):  http://<PC-LAN-IP>:8000/index.html

PORT=8000
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"   # project root (parent of dev/)

pid_on_port(){ ss -tlnp 2>/dev/null | grep ":$PORT " | grep -oP 'pid=\K[0-9]+' | head -1; }
lan_ip(){ hostname -I 2>/dev/null | awk '{print $1}'; }

case "${1:-status}" in
  start)
    P=$(pid_on_port)
    if [ -n "$P" ]; then echo "already serving on :$PORT (pid $P) — http://$(lan_ip):$PORT/index.html"; exit 0; fi
    ( cd "$DIR" && nohup python3 -m http.server "$PORT" --bind 0.0.0.0 >/tmp/usnea-serve.log 2>&1 & )
    sleep 1
    P=$(pid_on_port)
    echo "serving $DIR"
    echo "  → http://$(lan_ip):$PORT/index.html   (pid ${P:-?}, log: /tmp/usnea-serve.log)"
    ;;
  stop)
    P=$(pid_on_port)
    if [ -n "$P" ]; then kill "$P" && echo "stopped (was pid $P)"; else echo "not running on :$PORT"; fi
    ;;
  restart) "$0" stop; sleep 1; "$0" start;;
  status|*)
    P=$(pid_on_port)
    if [ -n "$P" ]; then echo "running: http://$(lan_ip):$PORT/index.html  (pid $P)"; else echo "not running"; fi
    ;;
esac
