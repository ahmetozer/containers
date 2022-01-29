FROM debian:bullseye
RUN set -x &&\
apt update && \
apt install curl  ca-certificates --no-install-recommends  -y && \
curl -s https://install.speedtest.net/app/cli/install.deb.sh -o install.sh && \
bash install.sh && rm install.sh && \
apt install speedtest -y  --no-install-recommends &&\
apt autoclean &&\
find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm

ENTRYPOINT ["/usr/bin/speedtest"]
