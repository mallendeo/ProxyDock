#!/bin/bash

echo "
random_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
" > proxychains.conf

count=5000

for f in $(cd VPN; bash -c ls)
do
  count=$((count+1))
  echo "http 127.0.0.1 $count" >> proxychains.conf
  docker run -d --cap-add=NET_ADMIN --device=/dev/net/tun --dns 8.8.8.8 -p $count:8080 -e "vpn=$f" pry0cc/proxydock
done
