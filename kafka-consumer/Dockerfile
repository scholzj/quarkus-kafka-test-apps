####
# Based on the Quarkus distroless image
###
FROM ghcr.io/scholzj/quarkus-multiarch-distroless-base:latest

LABEL org.opencontainers.image.source="https://github.com/scholzj/quarkus-kafka-test-apps/kafka-consumer/" \
      summary="Sample Kafka consumer written in Quarkus" \
      description="Sample Kafka consumer written in Quarkus"

COPY target/*-runner /application

EXPOSE 8080
USER nonroot

CMD ["./application"]