# # monolithic Galaxy version
  **Setup a standalone Galaxy instance in one machine.**  
  
  ## Requirements
  1. **Installed ubuntu(version >= 18.04) or centos7 amd64 version**
  2. **Installed docker and docker-compose[docker](../docker/README.md)**  
  
  ## Installation
  1. **docker-compose up -f galaxy.yml -d**
  
  ## How to 
  1. **Verify docker compose yaml, run "docker-compose -f docker-compose/galaxy.yml --env-file docker-compose/.env  config"**
  2. **Start Galaxy, run "docker-compose -f docker-compose/galaxy.yml --env-file docker-compose/.env  up -d"**