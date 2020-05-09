
#!/bin/sh

set -ex

if [ "$#" -lt  "2" ]
  then
    echo "You have not input the user and image."
    exit
fi

USERNAME=$1
IMAGE=$2

version=$(cat version)
echo "version: $version"

docker build -t $USERNAME/$IMAGE:latest ./

if [ "$#" -ge  "2" ]
  then
    docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
    docker push $USERNAME/$IMAGE:latest
    docker push $USERNAME/$IMAGE:$version
fi

