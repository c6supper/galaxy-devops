#!/bin/sh

set -xe
echo try install docker with $(logname)
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

position="veex_en"
if [ -n $1 ]; then
    position=$1
fi

#if in chengdu, replace default source list
if [ "$position" = "veex_cn" ]; then
    yum install -y wget
    wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
fi

yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotatdocker-engine \
		  docker-engine \
                  docker-ce

yum install -y yum-utils device-mapper-persistent-data lvm2
if [ "$position" = "veex_cn" ]; then
    yum-config-manager \
        --add-repo \
        http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
else
    yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
fi

yum install -y docker-ce docker-ce-cli containerd.io

usermod -aG docker $(logname)
gpasswd -a $USER docker

#install docker-compose
if [ "$position" = "veex_cn" ]; then
    curl -L "https://get.daocloud.io/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
else
    curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
fi
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

if [ "$position" = "veex_cn" ]; then
    rm -rf /etc/docker/daemon.json
    touch /etc/docker/daemon.json
    cat >> /etc/docker/daemon.json << EOF
    {
      "registry-mirrors": [
        "https://registry.docker-cn.com"
        "https://7y3a2yxf.mirror.aliyuncs.com"
      ]
    }
EOF
fi

systemctl restart docker
