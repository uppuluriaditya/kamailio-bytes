FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qy && apt-get -qy install sed openssl \
    tcpdump vim pkg-config dh-autoreconf ncurses-dev build-essential \
    libssl-dev libpcap-dev libncurses5-dev libsctp-dev lksctp-tools make

RUN apt-get upgrade

RUN apt-get install -qy cmake

RUN apt -y install git

RUN git clone https://github.com/SIPp/sipp.git

RUN cd sipp && cmake . -DUSE_SSL=1 -DUSE_SCTP=1 -DUSE_PCAP=1 -DUSE_GSL=1 && \
     make && cp sipp /usr/local/bin

COPY ./sipp-scenarios/* sipp-scenarios/

# ENTRYPOINT ["sipp"]

