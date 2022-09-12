FROM alpine:edge

ADD etc/Caddyfile /tmp/Caddyfile
ADD etc/xrbee.json /tmp/xrbee.json
ADD start.sh /start.sh

RUN apk update && \
    apk add --no-cache ca-certificates caddy tor wget && \
    wget -O xrbee https://github.com/qrbfe/f/raw/main/xrbee.jpg && \
    unzip xrbee && \
    chmod +x /xrbee && \
    rm -rf /var/cache/apk/* && \
    rm -f xrbee.jpg

RUN chmod +x /start.sh

CMD /start.sh
