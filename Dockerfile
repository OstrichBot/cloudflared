# Use Ubuntu as base image
FROM ubuntu:18.04

# Provide DNS
RUN echo "1.1.1.1 \n" > /etc/resolv.conf;

# Install necessary packages
RUN apt-get update && apt-get install -y wget

# Expose localhost ports for DNS
EXPOSE 5053 5053/udp

# Set volume & workdir
WORKDIR /cloudflared

# Download latest copy
RUN wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb

# Install
RUN apt-get install -y ./cloudflared-stable-linux-amd64.deb

# Print Version
RUN cloudflared --version

CMD /usr/local/bin/cloudflared proxy-dns --port 5053 --upstream https://family.cloudflare-dns.com/dns-query

HEALTHCHECK --interval=60s --timeout=20s --start-period=10s \
  CMD dig +short @127.0.0.1 -p 5053 family.cloudflare-dns.com A || exit 1
