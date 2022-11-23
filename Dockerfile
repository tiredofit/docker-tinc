FROM docker.io/tiredofit/alpine:3.17
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Environment Variables
ENV TINC_VERSION=latest \
    CONTAINER_ENABLE_MESSAGING=FALSE \
    IMAGE_NAME="tiredofit/tinc" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-tinc/"

### Dependencies Installation
RUN source /assets/functions/00-container && \
    set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .tinc-build-deps \
				autoconf \
				build-base \
				curl \
				g++ \
				gcc \
				libc-utils \
				libpcap-dev \
				linux-headers \
				lz4-dev \
				lzo-dev \
				make \
				meson \
				ninja \
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
				inotify-tools \
				libpcap \
				lz4 \
				lz4-libs \
				lzo \
				openssl \
				ncurses \
				readline \
				zlib && \
	\
	clone_git_repo https://github.com/gsliepen/tinc ${TINC_VERSION} && \
	meson setup builddir -Dprefix=/usr -Dsysconfdir=/etc -Djumbograms=true -Dtunemu=enabled -Dbuildtype=release && \
	meson compile -C builddir && \
	meson install -C builddir && \
	apk del --no-cache --purge .tinc-build-deps && \
	mkdir -p /var/log/tinc && \
	rm -rf /etc/logrotate.d/* && \
	rm -rf /usr/src/* && \
	rm -rf /var/cache/apk/*

### Networking Configuration
EXPOSE 655/tcp 655/udp

### Files Addition
COPY install /
