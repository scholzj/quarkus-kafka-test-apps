package cz.scholz.kafka.quarkus.streams;

import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.Consumed;
import org.apache.kafka.streams.kstream.Produced;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;

@ApplicationScoped
public class Streams {
    private static final Logger log = LoggerFactory.getLogger(Streams.class.getName());

    @Produces
    public Topology buildTopology() {
        StreamsBuilder builder = new StreamsBuilder();
        builder.stream("kafka-test-apps", Consumed.with(Serdes.String(), Serdes.String()))
                .mapValues(value -> {
                    StringBuilder sb = new StringBuilder();
                    sb.append(value);
                    return sb.reverse().toString();
                })
                .to("kafka-test-apps-reversed", Produced.with(Serdes.String(), Serdes.String()));

        return builder.build();
    }
}
