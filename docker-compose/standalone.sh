#!/bin/sh

set -e
set -o allexport
source "./.env"
set +o allexport

env | while read line; do
  if [ ! -z "$line" ] ; then
    if [[ $line == *"_VOLUME="* ]]; then
      echo "$line" | awk 'BEGIN { FS = "=" } ; { system("mkdir -p \""$2"\"") }'
    fi
  fi
done

docker-compose -f galaxy.yml restart