FROM alpine:latest

RUN apk add libc6-compat openjdk8-jre

WORKDIR /work/

COPY ./scripts/ /work
#COPY ./libs/ /work
COPY target/*-runner /work/application

RUN chmod 775 /work

EXPOSE 8080

CMD ["./run.sh", "./application -Djava.library.path=/usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/ -Dquarkus.http.host=0.0.0.0"]