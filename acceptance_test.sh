#!/bin/bash
#test $(curl "192.168.2.89:8765/sum?a=1&b=2") -eq 3
./gradlew acceptanceTest -Dcalculator.url=http://192.168.2.89:8765
