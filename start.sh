#!/bin/sh

AUUID="7777c110-6199-47d3-ba99-67a377e47777"
CADDYIndexPage="https://github.com/qrbfe/f/raw/main/w/web1.zip"
ParameterSSENCYPT="chacha20-ietf-poly1305"
PORT=80
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt && \
wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/ && \
cat /tmp/Caddyfile | sed -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile && \
cat /tmp/xrbee.json | sed -e "s/\$AUUID/$AUUID/g" -e "s/\$ParameterSSENCYPT/$ParameterSSENCYPT/g" >/xrbee.json




tor &
/xrbee -config /xrbee.json &
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
