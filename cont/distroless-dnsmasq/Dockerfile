
FROM debian:bullseye as build
RUN apt update && apt install -y dnsmasq --no-install-recommends
RUN if [ -d "/lib/aarch64-linux-gnu/" ]; then \
    export LINUX_GNU="aarch64-linux-gnu" ; \
elif [ -d "/lib/arm-linux-gnueabihf/" ];then \
    export LINUX_GNU="arm-linux-gnueabihf"; \
else  \
    export LINUX_GNU="x86_64-linux-gnu"; \
fi; \
cp -a --parents /usr/sbin/dnsmasq /opt && \
cp -a --parents /etc/dnsmasq.d /opt && \
cp -a --parents /etc/dnsmasq.conf /opt && \
cp -aL --parents /usr/share/dnsmasq /opt && \
cp -aL --parents /lib/$LINUX_GNU/libdbus* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libidn* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libnetfilter_conntrack* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libnettle.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libhogweed.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libgmp.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libsystemd.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libunistring.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libnfnetlink.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libmnl.so* /opt && \
cp -a --parents /lib/$LINUX_GNU/liblzma.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libzstd.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libgcrypt.so* /opt && \
cp -a --parents /lib/$LINUX_GNU/libgpg-error.so* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/liblz4.so* /opt && \
echo 


FROM gcr.io/distroless/base-debian11

COPY --from=build /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
ENTRYPOINT [ "/usr/sbin/dnsmasq", "-d"]