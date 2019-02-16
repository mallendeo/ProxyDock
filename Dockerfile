FROM alpine:3.7

RUN apk add --no-cache git openvpn bash supervisor python iptables

ADD supervisord/supervisord-openvpn.ini /etc/supervisor.d/supervisord-openvpn.ini
ADD VPN /VPN
ADD auth.txt /auth.txt
ADD scripts/start_vpn.sh /start_vpn.sh
RUN chmod 775 /start_vpn.sh

ADD scripts/proxy.py /proxy.py
ADD supervisord/supervisord-proxy.ini /etc/supervisor.d/supervisord-proxy.ini

EXPOSE 8080
CMD ["supervisord", "-n"]
