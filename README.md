# cloudflared
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/ostrichbot/cloudflared)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/ostrichbot/cloudflared)
![Docker Pulls](https://img.shields.io/docker/pulls/ostrichbot/cloudflared)

Docker cloudflared service with Family+Malware Protection

```
sudo docker run -d \
	--name cloudflared-family \
	-p 5053:5053/udp \
	--restart=unless-stopped \
	ostrichbot/cloudflared
```
