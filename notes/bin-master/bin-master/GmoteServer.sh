#!/usr/bin/env /bin/bash

echo "Starting GmoteServer 2.0 ... "
java -classpath bin:lib/jna.jar:lib/slf4j-api-1.5.3.jar:lib/swing-worker-1.2.jar org.gmote.server.GmoteServerUiLinux &
echo "GmoteServer started."
