FROM ubuntu:22.04

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && \
    sed -i "s/http:\/\/security.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list

RUN apt-get update && \ 
    apt-get -y install sudo openssh-server

RUN useradd -m ctf && echo "ctf:ctf" && \
    echo "ctf:ctf" | chpasswd

RUN ssh-keygen -A && \
    /etc/init.d/ssh start && \
    chsh -s /bin/bash ctf

COPY ./src/sudoers /etc/sudoers
COPY ./service/docker-entrypoint.sh /
COPY /etc/ssh/sshd_config /etc/ssh/sshd_config

ENTRYPOINT ["/bin/bash","/docker-entrypoint.sh"]