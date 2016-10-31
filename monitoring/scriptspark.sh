#!/bin/bash

wget https://github.com/Microsoft/OMS-Agent-for-Linux/releases/download/OMSAgent_GA_v1.2.0-25/omsagent-1.2.0-25.universal.x64.sh -O /tmp/omsagent.x64.sh
sudo sh /tmp/omsagent.x64.sh --upgrade
if [[ $HOSTNAME == hn* ]];
then
  sudo wget https://mohaeleastus2.blob.core.windows.net/oms/spark.headnode.conf -O /etc/opt/microsoft/omsagent/conf/omsagent.d/spark.headnode.conf
else
  sudo wget https://mohaeleastus2.blob.core.windows.net/oms/spark.workernode.conf -O /etc/opt/microsoft/omsagent/conf/omsagent.d/spark.workernode.conf
fi
sudo wget https://raw.githubusercontent.com/Azure/hbase-utils/master/monitoring/filter_hdinsight.rb -O /opt/microsoft/omsagent/plugin/filter_hdinsight.rb
sudo wget https://raw.githubusercontent.com/Azure/hbase-utils/master/monitoring/hdinsightmanifestreader.rb -O  /opt/microsoft/omsagent/bin/hdinsightmanifestreader.rb
sudo wget https://raw.githubusercontent.com/Azure/hbase-utils/master/monitoring/omsagent
sudo cp omsagent /etc/sudoers.d/
sudo sh ~/.bashrc
sudo sh -x /opt/microsoft/omsagent/bin/omsadmin.sh -w $1 -s $2
sudo service omsagent restart
