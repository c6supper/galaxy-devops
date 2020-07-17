#!/bin/sh
docker rm -f `docker ps -aq -f name=galaxy_*`
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

#docker-compose -f galaxy.yml restart
cat galaxy.template | envsubst | docker-compose -f - -p "galaxy" up -d