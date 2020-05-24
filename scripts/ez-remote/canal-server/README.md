# canal-server docker

* pull the building environment docker image from registry
    1. docker pull canal/canal-server:v1.1.4
    2. MySQL configuration must have the following lines:
        [mysqld]
        log-bin=mysql-bin
        binlog-format=ROW
        server_id=1
    3.Grant privileges for canal:
        CREATE USER canal IDENTIFIED BY 'canal';    
        GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canal'@'%';    
        FLUSH PRIVILEGES;
    4. Canal help:
        https://github.com/alibaba/canal/wiki/AdminGuide
    5.docker pull canal/canal-admin:v1.1.4
       
* Run docker
    1. follow instruction https://blog.csdn.net/daziyuanazhen/article/details/106098887
    2. sh run.sh/run_admin.sh for help (https://github.com/alibaba/canal/tree/canal-1.1.4/docker/run.sh)
    3. run example:
        ./run.sh -e canal.admin.manager=127.0.0.1:8089 \
                -e canal.admin.port=11110 \
                -e canal.admin.user=admin \
                -e canal.admin.passwd=4ACFE3202A5FF5CF467898FC58AAB1D615029441 \
                -e canal.admin.register.cluster=EZ-Remote

        ./run_admin.sh -e server.port=8089 \
            -e canal.adminUser=admin \
            -e canal.adminPasswd=admin
    3.canal.admin.passwd (encrypted by mysql select password(“123456”))
