FROM debian:buster-slim

ARG APP_HASH
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$APP_HASH \
      org.label-schema.build-date=$BUILD_DATE

WORKDIR /opt/domoticz

RUN apt-get update -y && \
    apt-get install -y wget curl make nano gcc g++ gdb libssl-dev git libcurl4-gnutls-dev libusb-dev python3-dev zlib1g-dev libcereal-dev liblua5.3-dev uthash-dev perl python-dev python-pip python3-pip && \
    pip install -U pymodbus && \
    mkdir -p /opt/domoticz/domoticz-homewizard && \
    wget -qO- https://releases.domoticz.com/releases/release/domoticz_linux_x86_64.tgz | tar xz -C /opt/domoticz && \
    git clone https://github.com/rvdvoorde/domoticz-homewizard.git /opt/domoticz/plugins/domoticz-homewizard && \
    cd /opt/domoticz/plugins/domoticz-homewizard && \
    chmod +x plugin.py && \
    rm -R  /opt/domoticz/plugins/domoticz-homewizard/domoticz-homewizard && \
    apt-get install speedtest-cli -y && \
    git clone https://github.com/addiejanssen/domoticz-solaredge-modbustcp-plugin.git /opt/domoticz/plugins/domoticz-solaredge-modbustcp-plugin && \
    cd /opt/domoticz/plugins/domoticz-solaredge-modbustcp-plugin && \
    chmod +x plugin.py && \ 
    pip3 install -r requirements.txt
    
EXPOSE 8080 443 6144

VOLUME /config

ENTRYPOINT [ "/opt/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log" ]

