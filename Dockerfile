FROM haproxy:2.1.3-alpine AS spoa-mirror
RUN apk add --no-cache \
                git automake autoconf build-base pkgconfig curl-dev libev-dev
WORKDIR /build
RUN git clone https://github.com/haproxytech/spoa-mirror /build && \
    git reset --hard 82f14a3f7bf8659e34505e0a681ed8c800105b9d
RUN ./scripts/bootstrap
RUN ./configure --enable-debug
RUN make all

FROM haproxy:2.1.3-alpine

RUN apk --no-cache upgrade \
 && apk add --no-cache libev libcurl ca-certificates openssl \
 && mkdir /etc/haproxy \
 && mkdir -p /opt/haproxy

COPY entrypoint.sh /bin/
COPY --from=spoa-mirror /build/src/spoa-mirror /bin/
COPY ./error-pages /opt/haproxy/error-pages

ENTRYPOINT ["/bin/entrypoint.sh"]
