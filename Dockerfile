FROM ubuntu:14.10
MAINTAINER lschmitz@pacificonline.com

#  - RUN - UPDATE
RUN apt-get update && apt-get install -y openssh-server supervisor
RUN mkdir -p /var/run/pdns /var/run/sshd /var/log/supervisor

ADD run.sh /run.sh
#ADD scrip file to change soucers

RUN ./run.sh
RUN apt-get update
RUN apt-get -y install pdns-server/vivid pdns-backend-remote/vivid
#First image-----------------------------------------------------------------------

ADD pdns.conf /etc/powerdns/pdns.conf
#ADD caralho.sh /caralho.sh
#RUN mkdir -p /etc/services/sshd /var/run/sshd

#CMD service pdns start && tail -F /var/log/pdns/error.log
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY pdns /usr/local/bin/
EXPOSE 53/udp 53/tcp 22
#ENTRYPOINT ["/usr/bin/supervisord"]
#CMD /usr/bin/supervisord
#ENTRYPOINT ["/etc/init.d"]
CMD pdns start && tail -F /var/log/pdns/error.log

