FROM tiredofit/alpine:edge
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Environment Variables
ENV TINC_VERSION=1.1pre17 \
	  ENABLE_SMTP=false

### Dependencies Installation       
RUN set -x && \
	 echo 'http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	 apk update && \
	 apk upgrade && \
	 \
	 apk add -t .tinc-build-deps \
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
							&& \
	 \
	 apk add -t .tinc-run-deps \
							ca-certificates \
							git \
							libcrypto1.1 \
							libpcap \
							lzo \
							openssl \
							readline \
							zlib && \
	 \
	 mkdir -p /usr/src/tinc && \
	 curl http://www.tinc-vpn.org/packages/tinc-${TINC_VERSION}.tar.gz | tar xzvf - --strip 1 -C /usr/src/tinc && \
	 cd /usr/src/tinc && \
	 ./configure --prefix=/usr --enable-jumbograms --enable-tunemu --sysconfdir=/etc --localstatedir=/var && \
	 make && make install src && \
	 apk del --no-cache --purge .tinc-build-deps && \
	 mkdir /var/log/tinc && \
	 rm -rf /usr/src/tinc && \
	 rm -rf /var/cache/apk/*

### Networking Configuration
EXPOSE 655/tcp 655/udp

### Files Addition
ADD install /
