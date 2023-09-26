FROM alpine

ARG TARGETARCH
ARG ETCD_VERSION=v3.5.9
ARG APISERVER_VERSION=v1.24.17

RUN apk add --update-cache curl tar runit upx && \
    curl -sSL https://github.com/etcd-io/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-${TARGETARCH}.tar.gz \
    | tar -vxz -C /usr/bin/ --strip=1 etcd-${ETCD_VERSION}-linux-${TARGETARCH}/etcd etcd-${ETCD_VERSION}-linux-${TARGETARCH}/etcdctl && \
    curl -sSL https://storage.googleapis.com/kubernetes-release/release/${APISERVER_VERSION}/bin/linux/${TARGETARCH}/kubectl -o /usr/bin/kubectl && \
    curl -sSL https://storage.googleapis.com/kubernetes-release/release/${APISERVER_VERSION}/bin/linux/${TARGETARCH}/kube-apiserver -o /usr/bin/kube-apiserver && \
    chown root:root /usr/bin/etcd /usr/bin/etcdctl /usr/bin/kubectl /usr/bin/kube-apiserver && \
    chmod +x /usr/bin/etcd /usr/bin/etcdctl /usr/bin/kubectl /usr/bin/kube-apiserver && \
    upx /usr/bin/etcd /usr/bin/etcdctl /usr/bin/kubectl /usr/bin/kube-apiserver && \
    apk del --purge curl tar upx && \
    rm -fr /var/cache/apk/

COPY run/etcd /etc/service/etcd/run
COPY run/kube-apiserver /etc/service/kube-apiserver/run
COPY kube/config /root/.kube/config
COPY kube/pki /etc/kubernetes/pki

VOLUME [ "/mnt/data/etcd.data" ]

CMD [ "/sbin/runsvdir", "-P", "/etc/service" ]

