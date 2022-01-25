FROM debian:bullseye
ENV DEBIAN_FRONTEND noninteractive
RUN  apt update && apt install -y curl wget libasound2  libaio1 libaio-dev libglu1 xdg-utils ca-certificates -y --no-install-recommends && \
 curl 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -L -o code.deb && \
 echo $(dpkg -i code.deb || echo "continue") && \
 apt --fix-broken install --no-install-recommends -y && \
 dpkg -i code.deb && rm -rf code.deb  && apt autoremove && apt clean && \
 find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm 
WORKDIR /root/


RUN adduser --disabled-password --gecos "" vscode && \
 apt update && \
 apt install git dbus-x11 gnome-keyring -y && \
 apt autoremove && apt clean && \
 find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm 
COPY container-start.sh /usr/bin/container-start.sh
COPY print-url.sh /usr/bin/print-url.sh
COPY print-url.desktop /usr/share/applications/print-url.desktop
COPY vscode-start.sh /usr/bin/vscode-start.sh
RUN chmod +x /usr/bin/container-start.sh && \
    chmod +x /usr/bin/print-url.sh && \
    chmod +x /usr/bin/vscode-start.sh && \
    chmod +x /usr/share/applications/print-url.desktop
CMD [ "/usr/bin/container-start.sh" ]
LABEL org.opencontainers.image.source = "https://github.com/ahmetozer/vscode-container"