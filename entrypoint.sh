#!/bin/sh

# encodes hostname, e.g. hss-mi-prod-15-1 to a string h-hmip15-1
export ERROR_PAGE_SELF_ID=$(hostname|awk -F "-" '{print substr($1,1,1)"-"substr($2,1,2) substr($3,1,1) $4"-"$5}')

for e_page in /opt/haproxy/error-pages/*; do
    sed -i "s/ERROR_PAGE_SELF_ID/${ERROR_PAGE_SELF_ID}/g" $e_page
done

cp -rf /opt/haproxy/error-pages /etc/haproxy/

exec haproxy -f /etc/haproxy/haproxy.cfg -W -db
