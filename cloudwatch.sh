#!/bin/bash

HOME=`dirname $0`

if $HOME/torrentWatcherMonitor.sh; then

  VALUE=1

else

  VALUE=0

fi

set -x
aws cloudwatch put-metric-data --metric-name TorrentWatcher --namespace Home --value $VALUE
