package cz.scholz.kafka.quarkus.producer;

import io.smallrye.mutiny.Multi;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import io.smallrye.reactive.messaging.kafka.OutgoingKafkaRecord;

import org.eclipse.microprofile.reactive.messaging.Outgoing;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.context.ApplicationScoped;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.Calendar;
import java.util.concurrent.atomic.AtomicLong;

@ApplicationScoped
public class Producer {
    private static final Logger log = LoggerFactory.getLogger(Producer.class.getName());
    private final int numberOfKeys = 10;
    private AtomicLong messageCount = new AtomicLong(0);

    @Outgoing("produced")
    public Multi<OutgoingKafkaRecord<String, String>> generate() {
        return Multi.createFrom().ticks().every(Duration.ofSeconds(1))
                .map(x -> {
                    long count = messageCount.incrementAndGet();
                    return produce(count);
                });
    }

    private OutgoingKafkaRecord<String, String> produce(Long count) {
        OutgoingKafkaRecord<String, String> msg = KafkaRecord.of("kafka-test-apps", getKey(count), "{ \"Message\": \"" + new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime()) + "\" }");

        log.info("Message sent with key {} and value {}", msg.getKey(), msg.getPayload());

        return msg;
    }

    private String getKey(long count) {
        return "{ \"key\": " + count % numberOfKeys + " }";
    }
}
