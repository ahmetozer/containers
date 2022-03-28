FROM debian:bullseye as build
RUN apt update && apt install -y privoxy libcap2-bin --no-install-recommends
RUN cp -a --parents /etc/privoxy /opt && \
cp -a --parents /usr/share/privoxy /opt && \
echo "nobody:x:65534:65534:Nobody:/:" > /opt/etc/passwd &&\
echo "nameserver 1.1.1.1" > /opt/etc/resolv.conf && \
echo "nameserver 2606:4700:4700::1111" >> /opt/etc/resolv.conf && \
chmod 644 /opt/etc/resolv.conf


COPY --from=ghcr.io/ahmetozer/distroless-helper /bin/distroless-helper /bin/distroless-helper
RUN /bin/distroless-helper /usr/sbin/privoxy /opt
RUN setcap CAP_NET_BIND_SERVICE=+eip /opt/usr/sbin/privoxy

FROM scratch
COPY --from=build /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
USER nobody
ENTRYPOINT [ "/usr/sbin/privoxy", "--no-daemon", "/etc/privoxy/config" ]