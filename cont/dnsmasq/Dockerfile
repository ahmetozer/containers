
FROM debian:bullseye as build
RUN apt update && apt install -y dnsmasq libcap2-bin --no-install-recommends
RUN cp -a --parents /etc/dnsmasq.d /opt && \
cp -a --parents /etc/dnsmasq.conf /opt && \
cp -aL --parents /usr/share/dnsmasq /opt && \
cp -aL --parents /etc/passwd /opt && \
cp -aL --parents /etc/group /opt && \
cp -aL --parents /etc/hosts /opt && \
echo "nameserver 1.1.1.1" > /opt/etc/resolv.conf && \
echo "nameserver 2606:4700:4700::1111" >> /opt/etc/resolv.conf && \
chmod 644 /opt/etc/resolv.conf


COPY --from=ghcr.io/ahmetozer/distroless-helper /bin/distroless-helper /bin/distroless-helper
RUN distroless-helper /usr/sbin/dnsmasq /opt
RUN setcap CAP_NET_BIND_SERVICE=+eip /opt/usr/sbin/dnsmasq
RUN distroless-helper $(whereis libnss_files.so.2| cut -d ' ' -f2)  /opt


FROM scratch
COPY --from=build /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
USER dnsmasq
ENTRYPOINT [ "/usr/sbin/dnsmasq", "-d"]