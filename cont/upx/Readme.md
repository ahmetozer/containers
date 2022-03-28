# Distroless UPX

This container image is created for UPX your binaries

Example :

```Dockerfile
FROM golang:1.18 as build
COPY ["main.go", "go.mod", "go.sum", "./"]

RUN go mod tidy
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o /bin/hello-world

FROM ghcr.io/ahmetozer/containers/upx as upx
COPY --from=build /bin/hello-world /bin/hello-world
RUN upx --brute /bin/hello-world

FROM scratch
COPY --from=upx /bin/hello-world /bin/hello-world
ENTRYPOINT ["/bin/hello-world"]
```
