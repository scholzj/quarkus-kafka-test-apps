FROM alpine:latest as jrebuilder

RUN apk add libc6-compat openjdk8-jre
RUN mkdir -p /tmp/tls-libs/lib \
  && cp /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/libsunec.so /tmp/tls-libs/lib \
  && cp /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts /tmp/tls-libs

FROM alpine:latest

RUN apk add libc6-compat openjdk8-jre

WORKDIR /work/

COPY ./scripts/ /work
COPY --from=jrebuilder /tmp/tls-libs/ /work/
COPY target/*-runner /work/application

RUN chmod 775 /work

EXPOSE 8080

CMD ["./run.sh", "./application -Djava.library.path=/work/lib -Djavax.net.ssl.trustStore=/work/cacerts -Dquarkus.http.host=0.0.0.0"]