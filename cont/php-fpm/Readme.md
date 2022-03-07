# Distroless PHP-FPM

This container image is created for run minimal php-fpm without any
distro.

This system based on Debian 11 and php8
php mysqli extension and msmtp is pre installed.

msmtp config location `/etc/msmtprc`

```bash
docker run -it --rm ghcr.io/ahmetozer/containers/php-fpm
```
