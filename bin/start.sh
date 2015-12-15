#!/usr/bin/env bash
###
# Run: ./bin/start.sh
###

RUN_ENV="development"

LIBPATH=("${HOME}"/opt/kafka_2.11-0.9.0.0/libs/*.jar)
for i in "${LIBPATH[@]}"
do
    CLASSPATH="$i:$CLASSPATH"
done

export CLASSPATH=$CLASSPATH
export BARCODE_1S_ENV=$RUN_ENV && bundle exec puma -e $RUN_ENV -C config/puma.rb
