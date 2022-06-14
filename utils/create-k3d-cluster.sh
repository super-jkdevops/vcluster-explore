#!/bin/bash

### Variables
clustername="${1:-"dev-cluster"}"
k3d_log="/tmp/$clustername-create.log"

### Create cluster if des not exist
if [[ $(k3d cluster list --no-headers | grep $clustername) ]]; then
  printf "%b" "\U26D4 Cluster: \e[1;34m$clustername\e[0m already exist!\n"
  exit
else
  printf "%b" "\U1F525 Creating Kubernetes Cluster: \e[1;34m$clustername\e[0m "
  k3d cluster create ${clustername} -c ./k3d/${clustername}.yaml >> $k3d_log &
fi
sp='/-\|'
printf ' '
while [ 1 ]; do
    k3d_progress=$(grep "created successfully" $k3d_log)
    if [ -z "$k3d_progress" ]; then
      printf '\b%.1s' "$sp"
      sleep 0.5
      sp=${sp#?}${sp%???}
    else
      printf "%b" "\n\U2705 Cluster: \e[1;34m$clustername\e[0m created\n"
      truncate -s 0 $k3d_log
      exit
    fi
done
