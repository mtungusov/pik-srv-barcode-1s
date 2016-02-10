#!/bin/bash

export RUN_ENV=development

gradle jrubyJar && java -jar ./build/libs/srv-barcode-1s-jruby.jar -S puma -b tcp://0.0.0.0:3000
