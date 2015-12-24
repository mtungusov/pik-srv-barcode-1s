# Dev
export ZK="kafka.dev:2181"
export KF_RF=1

## Topics
dev-1s-references-podrazdeleniya
dev-1s-references-sotrudniki

# Prod
export ZK="kbr01dsk2.dsk2.picompany.ru:2181 kbr02dsk2.dsk2.picompany.ru:2181 kbr03dsk2.dsk2.picompany.ru:2181"

# Ops
./bin/kafka-topics.sh --zookeeper $ZK --delete --topic

./bin/kafka-simple-consumer-shell.sh --broker-list $ZK --partition 0 --topic dev-1s-references-podrazdeleniya

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $KF_RF --partitions 1 \
--topic dev-1s-references-podrazdeleniya

./bin/kafka-topics.sh --zookeeper $ZK --create --replication-factor $KF_RF --partitions 1 \
--topic dev-1s-references-sotrudniki
