FROM haproxy:1.8.9-alpine

RUN apk --no-cache upgrade && apk add --no-cache ca-certificates openssl && mkdir /etc/haproxy && mkdir -p /opt/haproxy
COPY entrypoint.sh /bin/
COPY ./error-pages /opt/haproxy/error-pages

ENTRYPOINT ["/bin/entrypoint.sh"]


