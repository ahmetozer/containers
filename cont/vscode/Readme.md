# VSCODE Container

The reason for creating this system is to establish a temporary development environment in cases where there is an untrusted or one-time experimental environment.

It can be used to share only the software developed system and to isolate the development environment from the main system during collaborative studies.

## Start the environment

> Start VSCODE without storing any data

`DIPSLAY` variable and `/tmp/.X11-unix` volume share is used by vscode
to show gui on X server.

`ipc_lock` Capability is used for Gnome Keyring Deamon.

```bash
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix\
 --cap-add ipc_lock --name vscode ghcr.io/ahmetozer/containers:vscode
```

> To store project data permanently,  share your local folder with the container and open that folder in vscode to continue work.

```bash
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix\
 --cap-add ipc_lock -v /home/ahmet/project/hello:/project/hello \
 ghcr.io/ahmetozer/containers:vscode
```

If you want to keep your vscode configurations and plugins, you can
add another volume to `/home/vscode` to save changes.

```bash
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix\
 --cap-add ipc_lock -v /home/ahmet/project/hello:/project/hello \
 -v /home/ahmet/project/vscode-data:/home/vscode \
 ghcr.io/ahmetozer/containers:vscode
```

## Install packages inside container

Instead of giving root permission to vscode, execute bash with privileges
with docker to keep secure your environment.

```bash
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix\
 --cap-add ipc_lock -v /home/ahmet/project/hello:/project/hello \
 --name vscode -v /home/ahmet/project/vscode-data:/home/vscode \
 ghcr.io/ahmetozer/containers:vscode
```

```bash
docker exec -it vscode bash -c "apt update && apt install golang -y"
```
