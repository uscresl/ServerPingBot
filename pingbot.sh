#!/usr/bin/env bash
set -u

mkdir -p pingbot
echo "Welcome to pingbot v0.0.0"
echo "Monitoring hosts: $HOSTS"

while true; do
  for machine in $HOSTS; do
    machinedir=results/$machine
    mkdir -p $machinedir
    # Make sure files exist without updating mtime
    touch -a $machinedir/failure
    sleep 1s
    touch -a $machinedir/success
    # Do the acutal ping
    if ping -qc2 $machine > /dev/null 2>&1; then
      # Success
      if [ $machinedir/failure -nt $machinedir/success ]; then
        # New success
        echo "$machine: Newly online"
      fi
      touch $machinedir/success
    else
      # Failure
      if [ $machinedir/success -nt $machinedir/failure ]; then
        # New failure
        echo "$machine: Newly offline"
      fi
      touch $machinedir/failure
    fi
  done

  sleep 5s
done
