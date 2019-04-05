FROM scholzj/centos-java-base:latest

WORKDIR /work/

COPY ./scripts/ /work
COPY ./libs/ /work
COPY target/*-runner /work/application

RUN chmod 775 /work

EXPOSE 8080

CMD ["./run.sh", "./application -Dquarkus.http.host=0.0.0.0"]