#!/bin/bash

POD_NAME="yavor"
RETRIES=5
STEP=0

if ! microk8s kubectl get pods | grep ${POD_NAME} | awk '{print $3}' | grep -qv Running; then
  while [[ ${STEP} < ${RETRIES} ]]; do
    if ! microk8s kubectl get pods | grep ${POD_NAME} | awk '{print $3}' | grep -qv Running; then
      echo "Try $((STEP+1)) - Running"
      ((STEP++))
      sleep 5
    else
      echo "Try $((STEP+1)) - NOT Running"
      echo "Failed to start pod ${POD_NAME}!" | systemd-cat -p warning
      exit 1
    fi
  done
  echo "Successfully started"
else
  echo "Failed to start pod: ${POD_NAME}!"
  echo "Failed to start pod ${POD_NAME}!" | systemd-cat -p warning
fi