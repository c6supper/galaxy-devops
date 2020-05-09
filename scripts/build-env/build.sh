
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

docker build -t $NAME/$IMAGE:latest ./

if [ "$#" -ge  "2" ]
  then
    docker tag $NAME/$IMAGE:latest veex.docker.mirror:5000/$NAME/$IMAGE:latest
    docker tag veex.docker.mirror:5000/$NAME/$IMAGE:latest veex.docker.mirror:5000/$NAME/$IMAGE:$version
    docker push veex.docker.mirror:5000/$NAME/$IMAGE:latest
    docker push veex.docker.mirror:5000/$NAME/$IMAGE:$version
fi

