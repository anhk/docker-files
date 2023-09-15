FROM ubuntu

ARG TARGETARCH
ARG UpxBin=https://github.com/upx/upx/releases/download/v4.1.0/upx-4.1.0-${TARGETARCH}_linux.tar.xz

COPY sources.list.${TARGETARCH} /etc/apt/sources.list

RUN set -x && apt -y update && apt install -y wget tar xz-utils daemonize monit net-tools curl && \
    wget -O- ${UpxBin} | tar --xz -x && \
    cp -af upx-4.1.0-${TARGETARCH}_linux/upx /bin/upx && \
    rm -fr upx-4.1.0-${TARGETARCH}_linux && \
    apt clean && rm -fr /var/lib/apt/lists/* && \
    curl https://storage.googleapis.com/kubernetes-release/release/v1.24.17/bin/linux/${TARGETARCH}/kubectl -o /usr/bin/kubectl && \
    curl https://storage.googleapis.com/kubernetes-release/release/v1.24.17/bin/linux/${TARGETARCH}/kube-apiserver -o /usr/bin/kube-apiserver && \
    curl -L https://github.com/etcd-io/etcd/releases/download/v3.5.9/etcd-v3.5.9-linux-${TARGETARCH}.tar.gz -o /root/etcd-v3.5.9-linux-${TARGETARCH}.tar.gz && \
    cd /root/ && tar xvf etcd-v3.5.9-linux-${TARGETARCH}.tar.gz && \
    cp -af etcd-v3.5.9-linux-${TARGETARCH}/etcd* /usr/bin/ && \
    rm -fr /root/etcd-v3.5.9-linux-${TARGETARCH}* && \
    chmod +x /usr/bin/kubectl /usr/bin/kube-apiserver && \
    upx /usr/bin/kubectl /usr/bin/kube-apiserver /usr/bin/etcd

COPY --chmod=0600 monitrc /etc/monit/monitrc
COPY kube/config /root/.kube/config
COPY kube/pki /etc/kubernetes/pki

VOLUME [ "/mnt/data/etcd.data" ]

CMD [ "monit", "-I" ]
