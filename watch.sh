#!/bin/bash

STATSD_HOST=${STATSD_HOST:=localhost}
STATSD_PORT=${STATSD_PORT:=8125}
CONSOLE_URI=${CONSOLE_URI:=http://localhost:4444/grid/console}
METRIC=${METRIC:=deployment}

function statsd() {
   echo "${1}" | nc -w 1 -u $STATSD_HOST $STATSD_PORT
}


curl -sSL "${CONSOLE_URI}" > "result.xml";

TOTAL=$( cat result.xml | sed -e 's/>/>\n/g' | grep img | grep firefox | wc -l )
BUSY=$( cat result.xml | sed -e 's/>/>\n/g' | grep img | grep firefox | grep busy | wc -l)
QUEUE=$( cat result.xml | sed -e 's/>/>\n/g' | grep '<li' | grep -v tab | grep -v configuration | grep -v '<link' | wc -l)

statsd "${METRIC}.busy:${BUSY}|g"
statsd "${METRIC}.queue:${QUEUE}|g"
statsd "${METRIC}.total:${TOTAL}|g"
