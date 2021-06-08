FROM debian:bullseye

LABEL author="silkeh <Silke Hofstra>"
LABEL mantainer="Bensuperpc <bensuperpc@gmail.com>"
ARG VERSION="1.0.0"
ENV VERSION=$VERSION

# Install dependencies
RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
        ca-certificates \
        autoconf automake cmake dpkg-dev file git make patch \
        libc-dev libc++-dev libgcc-10-dev libstdc++-10-dev  \
        dirmngr gnupg2 lbzip2 wget xz-utils libtinfo5 && \
    rm -rf /var/lib/apt/lists/*

# Signing keys
ENV GPG_KEYS 09C4E7007CB2EFFB A2C794A986419D8A B4468DF4E95C63DC D23DD2C20DD88BA2 8F0871F202119294 0FC3042E345AD05D

# Retrieve keys
RUN gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys $GPG_KEYS

# Version info
ENV LLVM_RELEASE 7
ENV LLVM_VERSION 7.0.1

# Install Clang and LLVM
COPY install.sh .
RUN ./install.sh

LABEL org.label-schema.schema-version="1.0" \
	  org.label-schema.build-date=$BUILD_DATE \
	  org.label-schema.name="bensuperpc/docker-clang" \
	  org.label-schema.description="build clang compiler" \
	  org.label-schema.version=$VERSION \
	  org.label-schema.vendor="Bensuperpc" \
	  org.label-schema.url="http://bensuperpc.com/" \
	  org.label-schema.vcs-url="https://github.com/Bensuperpc/docker-clang" \
	  org.label-schema.vcs-ref=$VCS_REF \
	  org.label-schema.docker.cmd="docker build -t bensuperpc/clang -f Dockerfile ."
