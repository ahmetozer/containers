FROM debian:bullseye as build
RUN apt update && apt install -y privoxy --no-install-recommends
RUN if [ -d "/lib/aarch64-linux-gnu/" ]; then \
    export LINUX_GNU="aarch64-linux-gnu" ; \
elif [ -d "/lib/arm-linux-gnueabihf/" ];then \
    export LINUX_GNU="arm-linux-gnueabihf"; \
else  \
    export LINUX_GNU="x86_64-linux-gnu"; \
fi; \
cp -a --parents /usr/sbin/privoxy /opt && \
cp -a --parents /etc/privoxy /opt && \
cp -a --parents /usr/share/privoxy /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libbrotlidec.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libmbedtls.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libmbedx509.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libmbedcrypto.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/libz.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/libpcre.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libpcreposix.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libbrotlicommon.so.* /opt && \
echo "nobody:x:65534:65534:Nobody:/:" > /opt/etc/passwd

FROM gcr.io/distroless/base-debian11

COPY --from=build /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
USER nobody
ENTRYPOINT [ "/usr/sbin/privoxy", "--no-daemon", "/etc/privoxy/config" ]