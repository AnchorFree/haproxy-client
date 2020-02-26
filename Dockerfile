FROM haproxy:2.1.3-alpine

RUN apk --no-cache upgrade \
 && apk add --no-cache ca-certificates openssl \
 && mkdir /etc/haproxy \
 && mkdir -p /opt/haproxy

COPY entrypoint.sh /bin/
COPY ./error-pages /opt/haproxy/error-pages

ENTRYPOINT ["/bin/entrypoint.sh"]
