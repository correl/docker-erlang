FROM debian:jessie

MAINTAINER Correl Roush <correl@gmail.com>

ENV OTP_VERSION 17.3

RUN DEBIAN_FRONTEND=noninteractive  \
    apt-get update -qq \
    && apt-get install -y \
       build-essential \
       git \
       libncurses5-dev \
       openssl \
       libssl-dev \
       fop \
       xsltproc \
       unixodbc-dev

ADD http://erlang.org/download/otp_src_${OTP_VERSION}.tar.gz /usr/src/
RUN cd /usr/src \
    && tar xf otp_src_${OTP_VERSION}.tar.gz \
    && cd otp_src_${OTP_VERSION} \
    && ./configure \
    && make \
    && make install

ADD https://github.com/rebar/rebar/archive/master.tar.gz  /usr/src/rebar-master.tar.gz
RUN cd /usr/src \
    && tar zxf rebar-master.tar.gz \
    && cd rebar-master \
    && make \
    && cp rebar /usr/bin/rebar

ADD https://github.com/erlware/relx/archive/master.tar.gz /usr/src/relx-master.tar.gz
RUN cd /usr/src \
    && tar zxf relx-master.tar.gz \
    && cd relx-master \
    && make \
    && cp relx /usr/bin/relx

CMD ["erl"]
