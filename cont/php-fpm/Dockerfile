FROM php:fpm as phpfpmbin
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt update && apt install -y libcap2-bin msmtp
RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/local/sbin/php-fpm
RUN mkdir -p /opt/var/cache/nginx && \
if [ -d "/lib/aarch64-linux-gnu/" ]; then \
    export LINUX_GNU="aarch64-linux-gnu" ; \
elif [ -d "/lib/arm-linux-gnueabihf/" ];then \
    export LINUX_GNU="arm-linux-gnueabihf"; \
else  \
    export LINUX_GNU="x86_64-linux-gnu"; \
fi; \
cp -a --parents /usr/local/sbin/php-fpm /opt && \
cp -a --parents /usr/local/etc/php /opt && \
cp -a --parents /usr/local/etc/php-fpm.d /opt && \
cp -a --parents /usr/local/etc/php-fpm.conf /opt && \
cp -a --parents /usr/local/lib/php/ /opt && \
cp -a --parents /usr/bin/msmtp /opt && \
cp -a --parents /etc/passwd /opt && \
cp -a --parents /etc/group /opt && \
cp /usr/share/zoneinfo/${TIME_ZONE:-ROC} /opt/etc/localtime && \
cp -a --parents /lib/${LINUX_GNU}/*.so.*  /opt && \
cp -a --parents /usr/lib/${LINUX_GNU}/*.so.* /opt && \
echo 'set mta=/usr/bin/msmtp' > /etc/mail.rc && \
chmod 700 /etc/mail.rc && \
echo 'sendmail_path = "/usr/bin/msmtp -C /etc/msmtprc -t"' > /usr/local/etc/php/conf.d/mail.ini && \
echo done

FROM gcr.io/distroless/base-debian11

COPY --from=phpfpmbin /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
STOPSIGNAL SIGQUIT
EXPOSE 9000
ENTRYPOINT ["/usr/local/sbin/php-fpm"]
