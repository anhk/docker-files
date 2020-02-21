FROM centos:7

ENV NOTVISIBLE "in users profile"

RUN yum -y update && yum -y install openssh-server passwd && \
    mkdir -p /var/run/sshd && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    yum clean all && rm -fr /var/cache/yum

#RUN apt-get update && apt-get install -y openssh-server locales && \
#    mkdir /var/run/sshd && \
#    echo 'root:THEPASSWORDYOUCREATED' | chpasswd && \
#    sed -i '/#PermitRootLogin prohibit-password/a PermitRootLogin yes' /etc/ssh/sshd_config && \
#    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
#    locale-gen en_US.UTF-8 zh_CN.UTF-8 && \
#    echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
