# Dev
```
export KF="dev01dsk2.dsk2.picompany.ru:9092"
export ZK="dev01dsk2.dsk2.picompany.ru:2181"
export RF=1
```

# Prod
```
export KF="kbr01dsk2.dsk2.picompany.ru:9092 kbr02dsk2.dsk2.picompany.ru:9092 kbr03dsk2.dsk2.picompany.ru:9092"
export ZK="kbr01dsk2.dsk2.picompany.ru:2181 kbr02dsk2.dsk2.picompany.ru:2181 kbr03dsk2.dsk2.picompany.ru:2181"
export RF=3
```

# Ops
```
./bin/kafka-simple-consumer-shell.sh --broker-list $KF --partition 0 --topic dev-1s-references-podrazdeleniya
./bin/kafka-console-consumer.sh --property print.key=true --zookeeper $ZK --from-beginning --topic 1s-references-podrazdeleniya

./bin/kafka-topics.sh --zookeeper $ZK --list

./bin/kafka-topics.sh --zookeeper $ZK --delete --topic

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $RF --partitions 1 \
--topic 1s-references-podrazdeleniya

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $RF --partitions 1 \
--topic 1s-references-sotrudniki
```

## Topics
```
1s-references-podrazdeleniya
1s-references-sotrudniki
barcode-production-in
barcode-production-out
```

# Create topics
```
./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $RF --partitions 1 \
--topic 1s-references-podrazdeleniya

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $RF --partitions 1 \
--topic 1s-references-sotrudniki

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $RF --partitions 1 \
--topic barcode-production-in

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $RF --partitions 1 \
--topic barcode-production-out
```
