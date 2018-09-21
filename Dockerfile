FROM ubuntu:18.04

MAINTAINER Tremolo Security, Inc. - Docker <docker@tremolosecurity.com>

ENV JDK_VERSION=1.8.0 \
    OPENUNISON_VERSION="1.0.15"

LABEL io.k8s.description="Platform for building Tremolo Security OpenUnison" \
      io.k8s.display-name="OpenUnison Builder 1.0.15" 

RUN apt-get update;apt-get -y install openjdk-8-jdk-headless wget unzip python;apt-get -y upgrade;apt-get clean;rm -rf /var/lib/apt/lists/*; \
    mkdir -p /etc/openunison && \
    mkdir -p /etc/openunison-local && \
    mkdir -p /usr/local/openunison && \
    groupadd -r openunison -g 433 && \
    useradd -u 431 -r -g openunison -d /usr/local/openunison -s /sbin/nologin -c "OpenUnison Docker image user" openunison && \
    mkdir -p /usr/local/openunison/work && \
    mkdir -p /usr/local/openunison/work/webapp && \
    mkdir -p /usr/local/openunison/config && \
    mkdir -p /usr/local/openunison/quartz && \
    mkdir -p /usr/local/openunison/amq && \
    mkdir -p /usr/local/openunison/bin

ADD run_openunison.sh /usr/local/openunison/bin/run_openunison.sh
ADD check_alive.py /usr/local/openunison/bin/check_alive.py

RUN chown -R openunison:openunison \
    /etc/openunison \
    /etc/openunison-local \
    /usr/local/openunison \
  && chmod +x /usr/local/openunison/bin/*


USER 431

EXPOSE 8080
EXPOSE 8443

CMD ["/usr/local/openunison/bin/run_openunison.sh"]


