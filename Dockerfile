FROM docker.io/tiredofit/alpine:3.19
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV TINC_VERSION=7eeb29220a73ab9c5367f652873042f8a81c6cef \
    CONTAINER_ENABLE_MESSAGING=FALSE \
    IMAGE_NAME="tiredofit/tinc" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-tinc/"

RUN source /assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package add .tinc-build-deps \
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
    package add .tinc-run-deps \
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
    package remove .tinc-build-deps && \
    package cleanup && \
    mkdir -p /var/log/tinc && \
    rm -rf /etc/logrotate.d/* \
    rm -rf /usr/src/*

EXPOSE 655/tcp 655/udp

COPY install /
