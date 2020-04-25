# Use Ubuntu as base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y wget

# Set volume & workdir
WORKDIR /cloudflared

# Download & Install
RUN wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb
RUN apt-get install ./cloudflared-stable-linux-amd64.deb

ENV TZ="UTC" \
  TUNNEL_METRICS="0.0.0.0:49312" \
  TUNNEL_DNS_ADDRESS="0.0.0.0" \
  TUNNEL_DNS_PORT="5053" \
  TUNNEL_DNS_UPSTREAM="https://family.cloudflare-dns.com/dns-query"

RUN useradd -s /usr/sbin/nologin -r -M cloudflared && chown cloudflared:cloudflared /usr/local/bin/cloudflared
USER cloudflared

EXPOSE 5053/udp
EXPOSE 49312/tcp

ENTRYPOINT [ "/usr/local/bin/cloudflared" ]
CMD [ "proxy-dns" ]
