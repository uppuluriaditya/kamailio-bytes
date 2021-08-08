FROM debian:buster

LABEL maintainer="aditya Uppuluri <uppuluriaditya@gmail.com>"

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install --assume-yes gnupg wget && \
    echo "deb http://deb.kamailio.org/kamailio54 buster main" >   /etc/apt/sources.list.d/kamailio.list && \
    wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add - && \
    apt-get update && \
    apt-get install --assume-yes sngrep \
                        kamailio \
                        kamailio-autheph-modules \
                        kamailio-berkeley-bin \
                        kamailio-berkeley-modules \
                        kamailio-cnxcc-modules \
                        kamailio-cpl-modules \
                        kamailio-dbg \
                        kamailio-erlang-modules \
                        kamailio-extra-modules \
                        kamailio-geoip-modules \
                        kamailio-geoip2-modules \
                        kamailio-ims-modules \
                        kamailio-json-modules \
                        kamailio-kazoo-modules \
                        kamailio-ldap-modules \
                        kamailio-lua-modules \
                        kamailio-memcached-modules \
                        kamailio-mongodb-modules \
                        kamailio-mono-modules \
                        kamailio-mysql-modules \
                        kamailio-nth \
                        kamailio-outbound-modules \
                        kamailio-perl-modules \
                        kamailio-phonenum-modules \
                        kamailio-postgres-modules \
                        kamailio-presence-modules \
                        kamailio-python-modules \
                        kamailio-rabbitmq-modules \
                        kamailio-radius-modules \
                        kamailio-redis-modules \
                        kamailio-sctp-modules \
                        kamailio-snmpstats-modules \
                        kamailio-sqlite-modules \
                        kamailio-systemd-modules \
                        kamailio-tls-modules \
                        kamailio-unixodbc-modules \
                        kamailio-utils-modules \
                        kamailio-websocket-modules \
                        kamailio-xml-modules \
                        kamailio-xmpp-modules && \
    mkdir -p /db && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#Expose port 5060 (SIP) for TCP and UDP
EXPOSE 5060
EXPOSE 5060/udp

# RUN /usr/sbin/kamdbctl create

# RUN kamctl add 3001@192.168.0.177 '3001'
# RUN kamctl add 3000@172.18.0.3 '3000'

# RUN mkdir /etc/kamailio

# RUN mkdir db

COPY kamailio-data/* /etc/kamailio/

RUN /usr/sbin/kamdbctl create

RUN kamctl add 3001@192.168.0.177 3001

RUN kamctl add 3000@172.18.0.3 3000

# VOLUME [ "/db" ]
# COPY db/* /db/

ENTRYPOINT ["kamailio", "-DD", "-E"]
# CMD ["/usr/sbin/kamailio", "-m 64", "-M 8", "-D", "-E", "-e"]