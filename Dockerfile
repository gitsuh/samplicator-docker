FROM ubuntu 

USER root
RUN apt-get update && apt-get upgrade -y
RUN apt-get install make git autoconf automake gcc systemd-sysv libx32gcc1 runc -y
RUN apt-get install tcpdump -y
#RUN yum -y update && yum clean all

#RUN yum install make git autoconf automake gcc systemd-sysv libx32gcc1 libc6-dev-i386 -y

#RUN yum groupinstall "Development Tools" -y

RUN git clone https://github.com/sleinen/samplicator

WORKDIR ./samplicator

RUN ./autogen.sh

RUN ./configure

RUN make

RUN make install

RUN cp samplicator.service /etc/systemd/system/samplicator.service

RUN mkdir -p /opt/samplicator/etc/

COPY ./samplicator.conf /opt/samplicator/etc/samplicator.conf

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9090

ENTRYPOINT ["/entrypoint.sh"]
