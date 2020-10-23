FROM debian:buster-slim
WORKDIR /domoticz
EXPOSE 8080/tcp 443/tcp 6144
ENTRYPOINT [ "/domoticz/domoticz" ]
RUN apt-get update -y && \
    apt-get install -y wget libusb-0.1-4 python3.7-dev libcurl3-gnutls && \
    wget -q -O domoticz.tgz https://releases.domoticz.com/releases/release/domoticz_linux_x86_64.tgz && \
    tar xf domoticz.tgz && \
    rm domoticz.tgz *.txt
