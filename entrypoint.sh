#!/bin/sh
set -e
PORT="${PORT:-8080}"
UUID="${UUID:?UUID env var is required}"
cat > /etc/xray-config.json <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": ${PORT},
      "protocol": "vless",
      "settings": {
        "clients": [ { "id": "${UUID}" } ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "/${UUID}" }
      }
    }
  ],
  "outbounds": [ { "protocol": "freedom", "tag": "direct" } ]
}
EOF
exec /usr/local/bin/xray run -c /etc/xray-config.json
