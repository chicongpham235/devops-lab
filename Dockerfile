FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update
RUN apt-get install -y vim \
    cron

COPY log_archive_tool ./devops/log_archive_tool
RUN chmod -R 777 ./devops/

CMD ["cron", "&&", "tail", "-f", "/dev/null"]