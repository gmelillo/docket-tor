FROM ubuntu:18.04
MAINTAINER Gabriel Melillo <gabriel@melillo.me>

RUN apt-get update && apt-get install -y tor && \
	echo 'TorAddress 0.0.0.0' > /etc/tor/torsocks.conf && \
	echo 'TorPort 9050' >> /etc/tor/torsocks.conf && \
	echo 'OnionAddrRange 127.42.42.0/24' >> /etc/tor/torsocks.conf && \
	echo 'MaxCircuitDirtiness 1' >> /etc/tor/torsocks.conf && \
	echo 'AllowInbound 1' >> /etc/tor/torsocks.conf && \
	echo 'SOCKSPort 0.0.0.0:9050' > /etc/tor/torrc && \
	echo 'MaxCircuitDirtiness 10' >> /etc/tor/torrc && \
	echo 'DataDirectory /etc/tor/' >> /etc/tor/torrc && \
	echo 'User debian-tor' >> /etc/tor/torrc && \
	echo 'SocksPolicy accept *' >> /etc/tor/torrc && \
	chown debian-tor:debian-tor -R /etc/tor

EXPOSE 9050
CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]

