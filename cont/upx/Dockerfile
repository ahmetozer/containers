FROM debian as upxbase
RUN apt update && apt install upx --no-install-recommends -y

COPY --from=ghcr.io/ahmetozer/distroless-helper /bin/distroless-helper /bin/distroless-helper
RUN /bin/distroless-helper /usr/bin/upx /opt

FROM busybox:glibc
COPY --from=upxbase /opt /
LABEL org.opencontainers.image.source="https://github.com/ahmetozer/containers"
LABEL org.opencontainers.image.authors="Ahmet OZER"
