#!/bin/bash 

pid=`pgrep wf-recorder`
status=$?
savePath=$HOME/Videos/Captures
if [ $status != 0 ]
then 
  dimensions=$(slurp)
  if [ -n "$dimensions" ]
  then
    if [ ! -d "$savePath/$(date +'%d-%m-%Y')" ]; then
      mkdir -p "$savePath/$(date +'%d-%m-%Y')"
    fi
    timeout 6000 wf-recorder -r 60 -f $HOME/Videos/Captures/$(date +'%d-%m-%Y')/$(date +'Screen_recording_%H%M.mp4') -g "$dimensions" || exit
  fi
else 
  pkill --signal SIGINT wf-recorder
fi;
