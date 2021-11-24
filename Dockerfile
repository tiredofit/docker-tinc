FROM docker.io/tiredofit/alpine:3.15
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Environment Variables
ENV TINC_VERSION=1.1pre18 \
    CONTAINER_ENABLE_MESSAGING=FALSE

### Dependencies Installation
RUN set -x && \
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
						linux-headers \
						lzo-dev \
						make \
						ncurses-dev \
						libressl-dev \
						readline-dev \
						tar \
						zlib-dev \
						&& \
	\
	apk add -t .tinc-run-deps \
						ca-certificates \
						git \
						inotify-tools \
						libcrypto1.1 \
						libpcap \
						lzo \
						libressl \
						readline \
						zlib && \
	\
	mkdir -p /usr/src/tinc && \
	curl http://www.tinc-vpn.org/packages/tinc-${TINC_VERSION}.tar.gz | tar xzvf - --strip 1 -C /usr/src/tinc && \
	cd /usr/src/tinc && \
	./configure \
			--prefix=/usr \
			--enable-jumbograms \
			--enable-tunemu \
			--sysconfdir=/etc \
			--localstatedir=/var \
			&& \
	make -j$(getconf _NPROCESSORS_ONLN) && \
	make install src && \
	apk del --no-cache --purge .tinc-build-deps && \
	mkdir /var/log/tinc && \
	rm -rf /etc/logrotate.d/* && \
	rm -rf /usr/src/* && \
	rm -rf /var/cache/apk/*

### Networking Configuration
EXPOSE 655/tcp 655/udp

### Files Addition
ADD install /
