#!/bin/bash

if ping -c 1 192.168.1.2; then

  ACCOUNT=`wget -O - http://192.168.1.3/getActiveAccount 2>/dev/null`

  echo Active account is $ACCOUNT

  if [ "$ACCOUNT" != "uncapped" ]; then

    REMOTE_PROCESSES=`ssh Graeme@192.168.1.2 "/cygdrive/c/torrentWatcher/pslist.exe"` || exit 1

    if ! echo $REMOTE_PROCESSES | grep -i "Process information"; then

      echo Non-pslist.exe output detected, fail\!
      exit 1

    fi

    if echo $REMOTE_PROCESSES | grep -i torrent; then
 
      echo Argh\! Not on uncapped and torrents running\!
      echo Might aswell try to kill...
      ssh Graeme@192.168.1.2 "/cygdrive/c/torrentWatcher/pskill.exe utorrent"
      exit 1

    else

      echo All good, no torrent process found
      exit 0

    fi

  else

    echo On uncapped, no worries
  
  fi

else

  echo Gusteau asleep, no worries

fi



