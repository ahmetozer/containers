FROM debian:11 as build
RUN apt update
RUN apt install tor libcap2-bin -y --no-install-recommends

RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/tor && \
cp -a --parents /usr/bin/tor /opt && \
cp -a --parents /usr/sbin/tor /opt && \
cp -a --parents /etc/tor /opt && \
cp -aL --parents /usr/share/tor /opt && \
cp /usr/share/zoneinfo/${TIME_ZONE:-ROC} /opt/etc/localtime && \
mkdir -p /opt/home/nobody && chown -R nobody /opt/home/nobody && \
echo "nobody:x:65534:65534:Nobody:/home/nobody:" > /opt/etc/passwd

COPY --from=ghcr.io/ahmetozer/distroless-helper /bin/distroless-helper /bin/distroless-helper
RUN distroless-helper /usr/bin/tor /opt

FROM scratch
COPY --from=build /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
USER nobody
ENTRYPOINT  [ "/usr/bin/tor" ]