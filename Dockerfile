FROM tiredofit/alpine:edge
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Environment Variables
   ENV TINC_VERSION=1.1pre14

### Dependencies Installation       
   RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
       apk update && \
   
       BUILD_DEPS=" \
           autoconf \
           build-base \
           curl \
           g++ \
           gcc \
           libc-utils \
           libpcap-dev \
           libressl \
           linux-headers \
           lzo-dev \
           make \
           ncurses-dev \
           openssl-dev \
           readline-dev \
           tar \
           zlib-dev \
           " && \
   
       apk add ${BUILD_DEPS} \
           ca-certificates \
           git \
    	   libpcap \
    	   lzo \
         openssl \
	       readline \
   	     zlib && \
                   
       mkdir /tmp/tinc && \
       curl http://www.tinc-vpn.org/packages/tinc-${TINC_VERSION}.tar.gz | tar xzvf - --strip 1 -C /tmp/tinc && \
       cd /tmp/tinc && \
       ./configure --prefix=/usr --enable-jumbograms --enable-tunemu --sysconfdir=/etc --localstatedir=/var && \
       make && make install src && \
       apk del --no-cache --purge ${BUILD_DEPS} && \
       mkdir /var/log/tinc && \
       rm -rf /tmp/tinc && \
       rm -rf /var/cache/apk/*

### Files Addition
  ADD install /

### Networking Configuration
  EXPOSE 655/tcp 655/udp

### Entrypoint Configuration
  ENTRYPOINT ["/init"]
