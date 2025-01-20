FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y vim \
    cron
RUN cron

RUN mkdir -p /root/devops
RUN chmod -R 777 /root/devops

CMD ["tail", "-f", "/dev/null"]