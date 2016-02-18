# Dev
```
export ZK="dev01dsk2.dsk2.picompany.ru:2181"
export KF="dev01dsk2.dsk2.picompany.ru:9092"
export KF_RF=1
```

## Topics
```
dev-1s-references-podrazdeleniya
dev-1s-references-sotrudniki
```

# Prod
```
export ZK="kbr01dsk2.dsk2.picompany.ru:2181 kbr02dsk2.dsk2.picompany.ru:2181 kbr03dsk2.dsk2.picompany.ru:2181"
export KF="kbr01dsk2.dsk2.picompany.ru:9092 kbr02dsk2.dsk2.picompany.ru:9092 kbr03dsk2.dsk2.picompany.ru:9092"
```

# Ops
```
./bin/kafka-simple-consumer-shell.sh --broker-list $KF --partition 0 --topic dev-1s-references-podrazdeleniya
./bin/kafka-console-consumer.sh --zookeeper $ZK --from-beginning --topic 1s-references-podrazdeleniya

./bin/kafka-topics.sh --zookeeper $ZK --list

./bin/kafka-topics.sh --zookeeper $ZK --delete --topic

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $KF_RF --partitions 1 \
--topic 1s-references-podrazdeleniya

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $KF_RF --partitions 1 \
--topic 1s-references-sotrudniki
```
