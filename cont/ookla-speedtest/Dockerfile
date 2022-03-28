FROM debian:bullseye as stage1
RUN set -x &&\
apt update && \
apt install curl  ca-certificates --no-install-recommends  -y && \
curl -s https://install.speedtest.net/app/cli/install.deb.sh -o install.sh && \
bash install.sh && rm install.sh && \
apt install speedtest -y  --no-install-recommends &&\
apt autoclean &&\
find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm
COPY --from=ghcr.io/ahmetozer/distroless-helper /bin/distroless-helper /bin/distroless-helper
RUN /bin/distroless-helper /usr/bin/speedtest        /opt
RUN cp -a --parents /etc/ssl/ /opt

FROM scratch
COPY --from=stage1 /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
ENTRYPOINT ["/usr/bin/speedtest"]
