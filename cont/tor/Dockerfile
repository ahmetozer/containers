FROM debian:11 as build
RUN apt update
RUN apt install tor libcap2-bin -y --no-install-recommends

RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/tor
RUN if [ -d "/lib/aarch64-linux-gnu/" ]; then \
    export LINUX_GNU="aarch64-linux-gnu" ; \
elif [ -d "/lib/arm-linux-gnueabihf/" ];then \
    export LINUX_GNU="arm-linux-gnueabihf"; \
else  \
    export LINUX_GNU="x86_64-linux-gnu"; \
fi; \
cp -a --parents /usr/bin/tor /opt && \
cp -a --parents /usr/sbin/tor /opt && \
cp -a --parents /etc/tor /opt && \
cp -aL --parents /usr/share/tor /opt && \
cp -a --parents /lib/$LINUX_GNU/libz.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libevent-2.1.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libsystemd.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/liblzma.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libzstd.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libseccomp.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/libcap.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/liblz4.so.* /opt && \
cp -a --parents /usr/lib/$LINUX_GNU/libgcrypt.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/libgpg-error.so.* /opt && \
cp -a --parents /lib/$LINUX_GNU/libgcc_s.so.* /opt && \
cp /usr/share/zoneinfo/${TIME_ZONE:-ROC} /opt/etc/localtime && \
mkdir -p /opt/home/nobody && chown -R nobody /opt/home/nobody && \
echo "nobody:x:65534:65534:Nobody:/home/nobody:" > /opt/etc/passwd

FROM gcr.io/distroless/base-debian11
COPY --from=build /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
USER nobody
ENTRYPOINT  [ "/usr/bin/tor" ]