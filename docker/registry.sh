
#!/bin/sh

set -ex
docker stop registry-srv
docker stop registry-web
docker rm registry-srv
docker rm registry-web
docker pull hyper/docker-registry-web
docker run -d -p 5000:5000 --restart=always --name registry-srv   registry:2
docker run -d -p 9090:8080 --restart=always --name registry-web --link registry-srv -e REGISTRY_URL=http://registry-srv:5000/v2 -e REGISTRY_NAME=localhost:5000 hyper/docker-registry-web
