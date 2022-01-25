# bullseye is debian version
# nginx-1.20 is also use bullseye

## Nginx files from debian to prepare distroless system
FROM nginx:1.20 as nginxbin

ARG TIME_ZONE

RUN mkdir -p /opt/var/cache/nginx && \
if [ -d "/lib/aarch64-linux-gnu/" ]; then \
    export LINUX_GNU="aarch64-linux-gnu" ; \
elif [ -d "/lib/arm-linux-gnueabihf/" ];then \
    export LINUX_GNU="arm-linux-gnueabihf"; \
else  \
    export LINUX_GNU="x86_64-linux-gnu"; \
fi; \
cp -a --parents /usr/lib/nginx /opt && \
cp -a --parents /usr/share/nginx /opt && \
cp -a --parents /var/log/nginx /opt && \
cp -aL --parents /var/run /opt && \
cp -a --parents /etc/nginx /opt && \
cp -a --parents /etc/passwd /opt && \
cp -a --parents /etc/group /opt && \
cp -a --parents /usr/sbin/nginx /opt && \
cp -a --parents /usr/sbin/nginx-debug /opt && \
cp -a --parents /lib/$LINUX_GNU/ld-* /opt && \
cp -a --parents /lib/$LINUX_GNU/libpcre.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/libz.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/libc* /opt && \
cp -a --parents /lib/$LINUX_GNU/libdl* /opt && \
cp -a --parents /lib/$LINUX_GNU/libpthread* /opt && \
cp -a --parents /lib/$LINUX_GNU/libcrypt* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libssl.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libcrypto.so.* /opt && \
cp /usr/share/zoneinfo/${TIME_ZONE:-ROC} /opt/etc/localtime


FROM gcr.io/distroless/base-debian11

COPY --from=nginxbin /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
ENTRYPOINT [ "/usr/sbin/nginx" "-g 'daemon off;'" ]