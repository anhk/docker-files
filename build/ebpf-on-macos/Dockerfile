FROM ubuntu:latest
ARG TARGETARCH

COPY sources.list.${TARGETARCH} /etc/apt/sources.list
COPY entry /bin/entry

RUN apt update -y && \
    apt install -y build-essential git cmake \
        zlib1g-dev libevent-dev \
        libelf-dev llvm \
        clang libc6-dev

RUN mkdir /src && \
    git init
WORKDIR /src

# Link asm/byteorder.h into eBPF
RUN if [ "${TARGETARCH}" = "arm64" ]; then ln -s /usr/include/aarch-linux-gnu/asm/ /usr/include/asm; \
    else ln -s /usr/include/x86_64-linux-gnu/asm/ /usr/include/asm; fi; 

# Build libbpf as a static lib
RUN git clone https://github.com/libbpf/libbpf-bootstrap.git && \
    cd libbpf-bootstrap && \
    git submodule update --init --recursive

RUN cd libbpf-bootstrap/libbpf/src && \
    make BUILD_STATIC_ONLY=y && \
    make install BUILD_STATIC_ONLY=y LIBDIR=/usr/lib/x86_64-linux-gnu/

# Clones the linux kernel repo and use the latest linux kernel source BPF headers
RUN git clone --depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && \
    cp linux/include/uapi/linux/bpf* /usr/include/linux/

ENTRYPOINT "/bin/entry"
CMD "/bin/bash"