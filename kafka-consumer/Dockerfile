####
# Based on the Quarkus distroless image
###
FROM quay.io/quarkus/quarkus-distroless-image:1.0

LABEL org.opencontainers.image.source="https://github.com/scholzj/quarkus-kafka-test-apps/kafka-consumer/" \
      summary="Sample Kafka consumer written in Quarkus" \
      description="Sample Kafka consumer written in Quarkus"

COPY target/*-runner /application

EXPOSE 8080
USER nonroot

CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]