
#!/bin/sh

set -ex

if [ "$#" -lt  "2" ]
  then
    echo "You have not input the user and image."
    exit
fi

NAME=$1
IMAGE=$2

version=$(cat version)
echo "version: $version"

docker build --no-cache -t $NAME/$IMAGE -t $NAME/$IMAGE:$version ./

if [ "$#" -ge  "2" ]
  then
    docker login
    docker push $NAME/$IMAGE:latest
    docker push $NAME/$IMAGE:$version
fi

