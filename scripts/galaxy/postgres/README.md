# postgres 13 with client database initialization docker

* Dockerfile for postgres.
       
* Build docker
    1.export initialized SQL file to directory "schema"
    2.docker build --no-cache -t galaxy:postgres -f Dockerfile ./
