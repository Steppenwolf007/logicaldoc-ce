#!/bin/bash
set -eo pipefail
if [ ! -d /opt/logicaldoc/tomcat ]; then
 printf "Installing LogicalDOC\n"
 j2 /opt/logicaldoc/auto-install.j2 > /opt/logicaldoc/auto-install.xml
 # cat /opt/logicaldoc/auto-install.xml
 java --add-modules java.se.ee -jar /opt/logicaldoc/logicaldoc-installer.jar /opt/logicaldoc/auto-install.xml
 /opt/logicaldoc/bin/logicaldoc.sh stop
 /opt/logicaldoc/tomcat/bin/catalina.sh stop
 sed -i 's/8005/9005/g' /opt/logicaldoc/tomcat/conf/server.xml
else
 printf "LogicalDOC already installed\n"
fi

case $1 in
run)     echo "run";
	 /opt/logicaldoc/bin/logicaldoc.sh run
         ;;
start)   echo "start";
	 /opt/logicaldoc/bin/logicaldoc.sh start
         ;;
stop)    echo "STOOP!!!";
         /opt/logicaldoc/bin/logicaldoc.sh stop
         ;;
*) /opt/logicaldoc/bin/logicaldoc.sh $1
   ;;
esac


