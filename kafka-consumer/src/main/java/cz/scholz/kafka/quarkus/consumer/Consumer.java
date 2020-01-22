package cz.scholz.kafka.quarkus.consumer;

import io.smallrye.reactive.messaging.kafka.KafkaMessage;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.context.ApplicationScoped;
import java.util.concurrent.CompletionStage;

@ApplicationScoped
public class Consumer {
    private static final Logger log = LoggerFactory.getLogger(Consumer.class.getName());

    @Incoming("consumed")
    public CompletionStage<Void> consume(KafkaMessage<String, String> msg) {
        log.info("Received message (topic: {}, partition: {}) with key {}: {}", msg.getTopic(), msg.getPartition(), msg.getKey(), msg.getPayload());
        return msg.ack();
    }

    /*@Incoming("consumed")
    public void consumeString(String msg) {
        log.info("Received string: {}", msg);
    }*/
}
