FROM ubuntu

RUN set -x && apt -y update && apt install -y daemonize monit net-tools curl \
    && apt clean && rm -fr /var/lib/apt/lists/* \
    && curl https://storage.googleapis.com/kubernetes-release/release/v1.23.1/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
    && curl https://storage.googleapis.com/kubernetes-release/release/v1.23.1/bin/linux/amd64/kube-apiserver -o /usr/bin/kube-apiserver \
    && curl -L https://github.com/etcd-io/etcd/releases/download/v3.5.1/etcd-v3.5.1-linux-amd64.tar.gz -o /root/etcd-v3.5.1-linux-amd64.tar.gz \
    && cd /root/ && tar xvf etcd-v3.5.1-linux-amd64.tar.gz \
    && cp -af etcd-v3.5.1-linux-amd64/etcd* /bin/ \
    && rm -fr /root/etcd-v3.5.1-linux-amd64* \
    && chmod +x /bin/kubectl /bin/kube-apiserver

COPY --chmod=0600 monitrc /etc/monit/monitrc
COPY kube/config /root/.kube/config
COPY kube/pki /etc/kubernetes/pki
COPY --chmod=0755 entry.sh /entry.sh

ENTRYPOINT [ "/entry.sh" ]

CMD [ "/bin/bash" ]

