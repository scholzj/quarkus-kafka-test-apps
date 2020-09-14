package cz.scholz.kafka.quarkus.producer;

import io.quarkus.scheduler.Scheduled;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import io.smallrye.reactive.messaging.kafka.OutgoingKafkaRecord;

import org.eclipse.microprofile.reactive.messaging.Outgoing;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.context.ApplicationScoped;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicLong;

@ApplicationScoped
public class Producer {
    private static final Logger log = LoggerFactory.getLogger(Producer.class.getName());
    private final int numberOfKeys = 10;
    private AtomicLong messageCount = new AtomicLong(0);
    private BlockingQueue<Long> messages = new LinkedBlockingQueue<>();

    @Scheduled(every="1s")
    void schedule() {
        messages.add(messageCount.incrementAndGet());
    }

    @Outgoing("produced")
    public CompletionStage<OutgoingKafkaRecord<String, String>> send() {
        return CompletableFuture.supplyAsync(() -> {
            try {
                Long count = messages.take();
                return produce(count);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
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
