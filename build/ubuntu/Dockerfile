FROM ubuntu:22.04

#ARG TARGETARCH
ENV NOTVISIBLE "in users profile"
ENV SSH_PASSWORD

COPY ./entry /bin/entry
#COPY sources.list-${TARGETARCH} /etc/apt/sources.list

RUN apt-get update && apt-get install -y openssh-server locales && \
    mkdir /var/run/sshd && \
    echo 'root:THEPASSWORDYOUCREATED' | chpasswd && \
    sed -i '/#PermitRootLogin prohibit-password/a PermitRootLogin yes' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    locale-gen en_US.UTF-8 zh_CN.UTF-8 && \
    echo "export VISIBLE=now" >> /etc/profile

WORKDIR /root
EXPOSE 22
ENTRYPOINT ["/bin/entry"]
CMD ["/usr/sbin/sshd", "-D"]
