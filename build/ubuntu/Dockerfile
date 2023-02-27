FROM ubuntu:20.04

ENV NOTVISIBLE "in users profile"

COPY ./entry /bin/entry

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
