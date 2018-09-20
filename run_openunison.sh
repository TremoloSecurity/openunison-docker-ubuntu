#!/bin/bash

export OPENUNISON_DIR=/usr/local/openunison
export OPENUNISON_WORK=$OPENUNISON_DIR/work

# pull in the war file
wget $OPENUNISON_WAR_URL -O /usr/local/openunison/work/webapp/openunison.war


cd /usr/local/openunison/work/webapp
unzip openunison.war > /dev/null
rm -rf openunison.war
mv WEB-INF/lib ../
mv WEB-INF/classes ../
mkdir ../logs


export CLASSPATH="$OPENUNISON_WORK/lib/*:$OPENUNISON_WORK/classes:/tmp/quartz"
echo $CLASSPATH
java -classpath $CLASSPATH $JAVA_OPTS com.tremolosecurity.openunison.undertow.OpenUnisonOnUndertow /etc/openunison/openunison.yaml