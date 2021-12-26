####
# Based on the Quarkus distroless image
###
FROM ghcr.io/scholzj/quarkus-multiarch-distroless-base:latest

LABEL org.opencontainers.image.source="https://github.com/scholzj/quarkus-kafka-test-apps/kafka-streams/" \
      summary="Sample Kafka Streams app written in Quarkus" \
      description="Sample Kafka Streams app written in Quarkus"

COPY target/*-runner /application

EXPOSE 8080
USER nonroot

CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]