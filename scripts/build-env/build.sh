
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

docker build -t --no-cache $NAME/$IMAGE:latest ./

if [ "$#" -ge  "2" ]
  then
    docker login
    docker tag $NAME/$IMAGE:latest $NAME/$IMAGE:$version
    docker push $NAME/$IMAGE:latest
    docker push $NAME/$IMAGE:$version
fi

