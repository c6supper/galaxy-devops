#!/bin/sh
docker stop `docker ps -aq -f name=galaxy_*`
docker rm `docker ps -aq -f name=galaxy_*`
docker network prune -f
set -e
set -o allexport
source "./.env"
set +o allexport

until [ $# -eq 0 ]
do
  name=${1:1}; shift;
  if [[ -z "$1" || $1 == -* ]] ; then eval "export $name=true"; else eval "export $name=$1"; shift; fi
done

env | while read line; do
  if [ ! -z "$line" ] ; then
    if [[ $line == *"_VOLUME="* ]]; then
      echo "$line" | awk 'BEGIN { FS = "=" } ; { system("mkdir -p \""$2"\"") }'
    fi
  fi
done

#docker-compose -f galaxy.yml restart
cat galaxy.template.yaml | DOLLAR='$' envsubst | docker-compose -f - -p "galaxy" up -d
cat galaxy.template.yaml | DOLLAR='$' envsubst > docker-compose.yml
