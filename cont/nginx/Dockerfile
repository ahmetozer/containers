# bullseye is debian version
# nginx-1.20 is also use bullseye

## Nginx files from debian to prepare distroless system
FROM nginx:1.20 as nginxbin

ARG TIME_ZONE
RUN apt update && apt install -y libcap2-bin --no-install-recommends
COPY --from=ghcr.io/ahmetozer/distroless-helper /bin/distroless-helper /bin/distroless-helper
RUN /bin/distroless-helper /usr/sbin/nginx        /opt
RUN setcap CAP_NET_BIND_SERVICE=+eip /opt/usr/sbin/nginx 
RUN /bin/distroless-helper /usr/sbin/nginx-debug  /opt
RUN /bin/distroless-helper $(whereis libnss_files.so.2| cut -d ' ' -f2)  /opt
RUN mkdir -p /opt/var/cache/nginx && \
cp -a --parents /usr/lib/nginx /opt && \
cp -a --parents /usr/share/nginx /opt && \
cp -a --parents /var/log/nginx /opt && \
cp -aL --parents /var/run /opt && \
cp -aL --parents /etc/nginx /opt && \
cp -aL --parents /etc/passwd /opt && \
cp -a --parents /etc/group /opt && \
cp -aL --parents /etc/nsswitch.conf /opt && \
cp /usr/share/zoneinfo/${TIME_ZONE:-ROC} /opt/etc/localtime && \
mkdir -p /opt/var/cache/nginx && chown -R nginx:nginx /opt/var/cache/nginx && \
chown -R nginx:nginx /opt/var/run && chown -R nginx:nginx /opt/var/log/nginx

FROM scratch
COPY --from=nginxbin /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
USER nginx
ENTRYPOINT [ "/usr/sbin/nginx", "-g", "daemon off;" ]