FROM debian:buster-slim

ARG APP_HASH
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$APP_HASH \
      org.label-schema.build-date=$BUILD_DATE

WORKDIR /opt/domoticz

RUN apt-get update -y && \
    apt-get install -y wget curl make nano gcc g++ gdb libssl-dev git libcurl4-gnutls-dev libusb-dev python3-dev zlib1g-dev libcereal-dev liblua5.3-dev uthash-dev perl && \
    mkdir -p /opt/domoticz/domoticz-homewizard && \
    wget -qO- https://releases.domoticz.com/releases/release/domoticz_linux_x86_64.tgz | tar xz -C /opt/domoticz && \
    sed -i '/update2.html/d' /opt/domoticz/www/html5.appcache && \
    git clone https://github.com/rvdvoorde/domoticz-homewizard.git /opt/domoticz/plugins/domoticz-homewizard && \
    rm -R  /opt/domoticz/plugins/domoticz-homewizard/domoticz-homewizard -y
EXPOSE 8080 443 6144

VOLUME /config

ENTRYPOINT [ "/opt/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log" ]

