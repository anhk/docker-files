FROM ubuntu

ARG TARGETARCH
ARG UpxBin=bastion-pre.s3.cn-north-1.jdcloud-oss.com/upx-4.0.2-${TARGETARCH}_linux.tar.xz

COPY sources.list.${TARGETARCH} /etc/apt/sources.list

RUN set -x && apt -y update && apt install -y wget tar xz-utils daemonize monit net-tools curl && \
    wget -O- ${UpxBin} | tar --xz -x && \
    cp -af upx-4.0.2-${TARGETARCH}_linux/upx /bin/upx && \
    rm -fr upx-4.0.2-${TARGETARCH}_linux && \
    apt clean && rm -fr /var/lib/apt/lists/* && \
    curl https://storage.googleapis.com/kubernetes-release/release/v1.24.12/bin/linux/${TARGETARCH}/kubectl -o /usr/bin/kubectl && \
    curl https://storage.googleapis.com/kubernetes-release/release/v1.24.12/bin/linux/${TARGETARCH}/kube-apiserver -o /usr/bin/kube-apiserver && \
    curl -L https://github.com/etcd-io/etcd/releases/download/v3.5.1/etcd-v3.5.1-linux-${TARGETARCH}.tar.gz -o /root/etcd-v3.5.1-linux-${TARGETARCH}.tar.gz && \
    cd /root/ && tar xvf etcd-v3.5.1-linux-${TARGETARCH}.tar.gz && \
    cp -af etcd-v3.5.1-linux-${TARGETARCH}/etcd* /usr/bin/ && \
    rm -fr /root/etcd-v3.5.1-linux-${TARGETARCH}* && \
    chmod +x /usr/bin/kubectl /usr/bin/kube-apiserver && \
    upx /usr/bin/kubectl /usr/bin/kube-apiserver /usr/bin/etcd

COPY --chmod=0600 monitrc /etc/monit/monitrc
COPY kube/config /root/.kube/config
COPY kube/pki /etc/kubernetes/pki

VOLUME [ "/mnt/data/etcd.data" ]

CMD [ "monit", "-I" ]
